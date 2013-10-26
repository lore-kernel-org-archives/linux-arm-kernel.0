From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 26 Oct 2013 23:00:49 +0200
Subject: Subsystem/interface for a 16x2 character LCD driver?
Message-ID: <87iowjrblq.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I did not know where to ask but because it is related to an ARM
platform, I decide to start here. NETGEAR ReadyNAS 104 has a front
16x2 characters backlight-capable LCD (Winstar WH1608). It is
controlled via 11 GPIOS.

I am starting to write a driver for it to be able to pass messages (via
/proc?) from userland to be displayed on the LCD and also enable/disable
the backlight. I just wonder where it should go (auxdisplay? staging?
video/backlight? drivers/misc?), if there are existing interfaces for
such beasts and on which existing driver (if any) I could base my dev.

If you have any idea where/who I can ask, do not hesitate. Additionally,
if someone has thoughts on what the DT interface should look like for
such a device, I am interested.

Cheers,

a+
