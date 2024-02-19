class AdMob {
  static bool isTest = false;
  static List<String> testDevices = ['id1', 'id2'];
  static Map<String, Map<String, String>> productionAdIds = {
    'ios': {
      'banner': 'banner_id',
      'interstitial': 'interstitial_id',
      'reward': 'reward_id',
    },
    'android': {
      'banner': 'banner_id',
      'interstitial': 'interstitial_id',
      'reward': 'reward_id',
    }
  };

  static Map<String, Map<String, String>> testAdIds = {
    'ios': {
      'banner': 'banner_id',
      'interstitial': 'interstitial_id',
      'reward': 'reward_id',
    },
    'android': {
      'banner': 'banner_id',
      'interstitial': 'interstitial_id',
      'reward': 'reward_id',
    }
  };

  static String? getAdId({required String deviceType, required String adType}) {
    if(isTest) {
      return testAdIds[deviceType]?[adType];
    } else {
      return productionAdIds[deviceType]?[adType];
    }
  }
}