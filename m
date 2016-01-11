From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 11 Jan 2016 17:34:31 +0100
Subject: [PATCH] ARM: mvebu: Update the mpp63 function in the device tree
 on Armada 370
In-Reply-To: <20151223151221.GM18249@io.lakedaemon.net> (Jason Cooper's
 message of "Wed, 23 Dec 2015 15:12:21 +0000")
References: <1450881770-21189-1-git-send-email-gregory.clement@free-electrons.com>
 <20151223151221.GM18249@io.lakedaemon.net>
Message-ID: <874mekyt0o.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On mer., d?c. 23 2015, Jason Cooper <jason@lakedaemon.net> wrote:

> On Wed, Dec 23, 2015 at 03:42:50PM +0100, Gregory CLEMENT wrote:
>> Since the commit a526973e0291 ("pinctrl: mvebu: Fix mapping of pin
>> 63 (gpo -> gpio)"), the mpp63 is no more declared as a GPO but is a
>> GPIO. Even if in the datasheet this pin is described as GPO, the
>> experience of the D-Link DNS-327L board shows that it can be used as a
>> GPIO.
>> 
>> This commits generated warnings for the board using this pin as gpo, with
>> this patch the dts are fixed by using the new function (gpio) instead of
>> the old one.
>> 
>> The binding documentation has also been updated accordingly.
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>
> Acked-by: Jason Cooper <jason@lakedaemon.net>

Applied to mvebu/dt-for-4.6 with Jason Acked-by

Gregory

>
> thx,
>
> Jason.

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
