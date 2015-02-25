From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 25 Feb 2015 13:41:01 +0100
Subject: Ethernet Briding broken on APM Mustang on v4.0-rc1
Message-ID: <20150225124101.GD12827@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Configuring bridged networking on the APM Mustang platform doesn't work
on v4.0-rc1.  It works fine on v3.19-rc1.

When adding the interface to the bridge I get this error:

can't add eth0 to bridge br0: Invalid argument

Has anyone else seen this?

Other ARMv8 platforms don't seem to be affected by this.

Thanks,
-Christoffer
