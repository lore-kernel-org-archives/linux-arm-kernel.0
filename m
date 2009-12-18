From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Fri, 18 Dec 2009 18:11:31 +0100
Subject: [PATCH 0/2] mx31moboard for 2.6.33-rc1 
Message-ID: <1261156293-13981-1-git-send-email-valentin.longchamp@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have tested mx31moboard with the first -rc. Here are two patches correcting the current problems. They should go to a next -rc.

1) The patches for usbh support were based on the bad branch, where the platform_devices had been renamed. Now this prevents the mx3 config to build. The first patch reverts to the correct names.

2) The MC13783 voltage regulators with boot_on or always_on enabled hang the kernel at boot. Remove these options from mx31moboard configuration. Sascha, is this a correct behavior or is it a bug ?

Thanks

Val 
