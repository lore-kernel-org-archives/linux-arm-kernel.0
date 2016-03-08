From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 08 Mar 2016 14:01:06 +0100
Subject: [PATCH v4 0/3] driver for the hardware monitoring chip in the
 Zyxel NSA320
In-Reply-To: <20160308115506.GA25899@roeck-us.net> (Guenter Roeck's message of
 "Tue, 8 Mar 2016 03:55:06 -0800")
References: <1457192097-32538-1-git-send-email-linux@baker-net.org.uk>
 <20160308115506.GA25899@roeck-us.net>
Message-ID: <87mvq93yzx.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Adam and Guenter,
 
 On mar., mars 08 2016, Guenter Roeck <linux@roeck-us.net> wrote:

> On Sat, Mar 05, 2016 at 03:34:54PM +0000, Adam Baker wrote:
>>  Documentation/devicetree/bindings/hwmon/nsa320-mcu.txt |  21 +++++
>>  Documentation/hwmon/nsa320                             |  53 +++++++++++
>>  arch/arm/boot/dts/kirkwood-nsa320.dts                  |  13 ++-
>>  drivers/hwmon/Kconfig                                  |  15 +++
>>  drivers/hwmon/Makefile                                 |   1 +
>>  drivers/hwmon/nsa320-hwmon.c                           | 216 ++++++++++++++++++++++++++++++++++++++++++++
>>  6 files changed, 317 insertions(+), 2 deletions(-)
>> 
> Patch 1/3 and 2/3 applied to hwmon-next.
>
> I assume that patch 3/3 will go through the arm tree.

Yes but now that the rc7 was released is too late putting it to arm-soc
for the 4.6 kernel.

Gregory

>
> Guenter

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
