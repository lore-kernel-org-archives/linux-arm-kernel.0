From: private@roeck-us.net (Guenter Roeck)
Date: Wed, 23 Dec 2015 20:38:56 -0800
Subject: Running arm:versatile_defconfig with qemu in linux-next
Message-ID: <567B76E0.6050106@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

various versatile and realview configurations fail to run for me with
qemu (2.5) in linux-next. Some of those are qemu configurations
I collected from various sources, so I guess I am on my own there.
However, the following standard configurations no longer work.

arm:versatileab:versatile_defconfig
arm:versatilepb:versatile_defconfig

I can no longer get realview-eb-mpcore and realview-eb to work either,
but, again, that is with a qemu specific configuration.

I tried to bisect, but there have been too many related changes in the code
for it to succeed; some of the bisect attempts don't even compile, others fail
due to different problems. Is it known if versatile_defconfig in linux-next runs
on a real system ? If so, any idea what it might take to get it to work again
with qemu ?

Thanks,
Guenter
