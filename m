From: mpeg.blue@free.fr (Mason)
Date: Wed, 19 Nov 2014 18:19:27 +0100
Subject: Looking for good references for ARM driver development
In-Reply-To: <546CCBF6.7070607@gmail.com>
References: <546C920A.7060800@free.fr> <546CCBF6.7070607@gmail.com>
Message-ID: <546CD11F.6050502@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/11/2014 17:57, Victor Ascroft wrote:

> This actually depends on the kernel you are using. Do you have relatively
> new kernel or an old one? Depending on that, either you will get that
> information in a board file or else in the device tree in arch/arm/boot/dts.

I'll reply more thoroughly later, but I wanted to address this question.
We're targeting kernel 3.14.x

> This depends. If you have driver compiled in with the kernel this will happen
> on kernel boot up. If you have the driver as a loadable module, the probe hook
> will be called on modprobe or insmod.

Is this an answer to question 5?
I think there is some confusion with the "probe" terminology.

I meant "probe" as in "read the current value".
I think you mean "probe" as in "the driver probes for the device through
the probe method."

I meant to ask how often the hwmon framework "polls" the temperature sensor.

Regards.
