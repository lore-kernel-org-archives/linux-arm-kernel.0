From: lkp@intel.com (kbuild test robot)
Date: Sun, 22 Nov 2015 21:57:27 +0800
Subject: [PATCH v4 2/2] drm/bridge: Add I2C based driver for ps8640 bridge
In-Reply-To: <1448186471-10413-2-git-send-email-jitao.shi@mediatek.com>
Message-ID: <201511222158.uE7YWqMV%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jitao,

[auto build test ERROR on: drm/drm-next]
[also build test ERROR on: v4.4-rc1 next-20151120]

url:    https://github.com/0day-ci/linux/commits/Jitao-Shi/Documentation-bridge-Add-documentation-for-ps8640-DT-properties/20151122-180613
base:   git://people.freedesktop.org/~airlied/linux.git drm-next
config: alpha-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=alpha 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `ps8640_post_disable':
>> drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8b944): undefined reference to `drm_err'
   drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8b94c): undefined reference to `drm_err'
   drivers/built-in.o: In function `ps8640_bridge_attach':
   (.text+0x8b990): undefined reference to `drm_err'
   drivers/built-in.o: In function `ps8640_bridge_attach':
   (.text+0x8b99c): undefined reference to `drm_err'
   drivers/built-in.o: In function `ps8640_bridge_attach':
   (.text+0x8b9b8): undefined reference to `drm_connector_init'
   drivers/built-in.o: In function `ps8640_bridge_attach':
   (.text+0x8b9c8): undefined reference to `drm_connector_init'
   drivers/built-in.o: In function `ps8640_bridge_attach':
   (.text+0x8b9e0): undefined reference to `drm_err'
   drivers/built-in.o: In function `ps8640_bridge_attach':
   (.text+0x8b9ec): undefined reference to `drm_err'
   drivers/built-in.o: In function `ps8640_bridge_attach':
   (.text+0x8ba00): undefined reference to `drm_connector_register'
   drivers/built-in.o: In function `ps8640_bridge_attach':
   (.text+0x8ba14): undefined reference to `drm_connector_register'
   drivers/built-in.o: In function `ps8640_bridge_attach':
   (.text+0x8ba28): undefined reference to `drm_mode_connector_attach_encoder'
   drivers/built-in.o: In function `ps8640_bridge_attach':
   (.text+0x8ba30): undefined reference to `drm_mode_connector_attach_encoder'
   drivers/built-in.o: In function `ps8640_bridge_attach':
   (.text+0x8ba44): undefined reference to `drm_panel_attach'
   drivers/built-in.o: In function `ps8640_bridge_attach':
   (.text+0x8ba4c): undefined reference to `drm_panel_attach'
   drivers/built-in.o: In function `ps8640_disable':
   drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8bad0): undefined reference to `drm_err'
   drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8bad8): undefined reference to `drm_err'
   drivers/built-in.o: In function `ps8640_regw':
>> drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8bb6c): undefined reference to `i2c_master_send'
   drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8bba4): undefined reference to `i2c_master_send'
   drivers/built-in.o: In function `ps8640_regr':
   drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8bc00): undefined reference to `i2c_master_send'
   drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8bc34): undefined reference to `i2c_master_send'
>> drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8bc70): undefined reference to `i2c_master_recv'
   drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8bc80): undefined reference to `i2c_master_recv'
   drivers/built-in.o: In function `ps8640_connector_destroy':
>> drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8bce0): undefined reference to `drm_connector_unregister'
   drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8bcf0): undefined reference to `drm_connector_unregister'
>> drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8bd00): undefined reference to `drm_connector_cleanup'
   drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8bd04): undefined reference to `drm_connector_cleanup'
   drivers/built-in.o: In function `ps8640_remove':
>> drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8bd2c): undefined reference to `drm_bridge_remove'
   drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8bd3c): undefined reference to `drm_bridge_remove'
   drivers/built-in.o: In function `ps8640_prepare':
   drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8bdb8): undefined reference to `drm_err'
   drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8bdc0): undefined reference to `drm_err'
   drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8be08): undefined reference to `drm_err'
   drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8be10): undefined reference to `drm_err'
   drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8be40): undefined reference to `drm_err'
   drivers/built-in.o:drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8be48): more undefined references to `drm_err' follow
   drivers/built-in.o: In function `ps8640_probe':
>> drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8c388): undefined reference to `of_drm_find_panel'
   drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8c390): undefined reference to `of_drm_find_panel'
>> drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8c3d8): undefined reference to `i2c_new_dummy'
   drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8c3f0): undefined reference to `i2c_new_dummy'
>> drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8c560): undefined reference to `drm_bridge_add'
   drivers/gpu/drm/bridge/parade-ps8640.o:(.text+0x8c578): undefined reference to `drm_bridge_add'
   drivers/built-in.o: In function `ps8640_driver_init':
>> drivers/gpu/drm/bridge/parade-ps8640.o:(.init.text+0x589c): undefined reference to `i2c_register_driver'
   drivers/gpu/drm/bridge/parade-ps8640.o:(.init.text+0x58ac): undefined reference to `i2c_register_driver'
>> drivers/built-in.o:(.data.rel.ro+0x12a0): undefined reference to `drm_atomic_helper_connector_dpms'
>> drivers/built-in.o:(.data.rel.ro+0x12b8): undefined reference to `drm_atomic_helper_connector_reset'
>> drivers/built-in.o:(.data.rel.ro+0x12c8): undefined reference to `drm_helper_probe_single_connector_modes'
>> drivers/built-in.o:(.data.rel.ro+0x12e8): undefined reference to `drm_atomic_helper_connector_duplicate_state'
>> drivers/built-in.o:(.data.rel.ro+0x12f0): undefined reference to `drm_atomic_helper_connector_destroy_state'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 44022 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151122/4d376fa8/attachment-0001.obj>
