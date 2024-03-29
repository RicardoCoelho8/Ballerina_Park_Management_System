package labdsoft.park_bo_mcs.services;

import labdsoft.park_bo_mcs.dtos.park.*;

import java.util.List;

public interface ParkService {
    List<OccupancyParkDTO> getCurrentNumberOfAvailableSpotsInsideAllParks() throws Exception;
    List<PriceTableEntryDTO> getAllPriceTableEntriesById(Long parkId);
    List<NearbyParkOccupancyDTO> getRealTimeNearbyParksOccupancy(double latitude, double longitude, double maxDistanceKm);
    List<ParkHistoryDTO> getAllParkingHistoryByCustomerID(Long customerID);
    ResponseString enableDisableSpot(SpotHistoryDTO spotHistoryDTO);
    ResponseString changeParkyThresholds(String parkNumber, ParkyConfigDTO parkyConfigDTO);
    ResponseString enableDisableOvernightFeeByParkNumber(OvernightEnableDTO dto);
    ResponseString changeOvernightFeePriceByParkNumber(OvernightPriceDTO dto);
    ParkyConfigDTO getParkyThresholds(String parkNumber);
    OvernightConfigDTO getOvernightConfigByParkNumber(String parkNumber);
    Integer getQuantityOfHistoryByCustomerID(String customerID);
    void createPark(String string);
    ResponseString changeUserParkyFlag(ParkyFlagDTO parkyFlagDTO);
    List<String> getAllParks();
    List<SpotDTO> getSpotsByParkNumber(String parkNumber);
    Boolean getUserParkyFlagByCustomerID(String customerID);
    List<PriceTableEntryDTO> defineTimePeriods(String parkNumber, List<PriceTableEntryDTO> priceTableEntryDTO);
}
