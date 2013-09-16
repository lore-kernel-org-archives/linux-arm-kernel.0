From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Sep 2013 10:47:33 +0100
Subject: [PATCH 27/38] iio: pressure-core: st: Give some indication if
 device probing was successful
In-Reply-To: <FEAE1C531EE4684EBDD22603EC8BE59931CAB11B@NWD2MBX7.ad.analog.com>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-28-git-send-email-lee.jones@linaro.org>
 <43055af7-991f-4122-b308-a3dcddbbb72a@email.android.com>
 <20130911071053.GD11227@lee--X1> <52301963.5030006@metafoo.de>
 <20130911072955.GG11227@lee--X1>
 <FEAE1C531EE4684EBDD22603EC8BE59931CAB11B@NWD2MBX7.ad.analog.com>
Message-ID: <20130916094733.GH3999@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> echo "working:"
> cat /sys/bus/iio/devices/*/name
> 
> isn't too much digging. If you really want to do that on your machine - do so in rc.local

Okay, I was going round the long way, which is why is was difficult:

  /sys/class/i2c-adapter/i2c-2/2-005c/iio\:device2/name

I will revert the "registered" patches.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
