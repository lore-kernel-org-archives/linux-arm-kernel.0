From: vivien.didelot@savoirfairelinux.com (Vivien Didelot)
Date: Fri, 23 Aug 2013 15:40:18 -0400 (EDT)
Subject: [PATCH] misc: (at24) move header to linux/platform_data/
In-Reply-To: <1377285996.620418788@f48.i.mail.ru>
Message-ID: <276016030.909379.1377286818459.JavaMail.root@mail>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Alexander wrote:
> Can this file be additionally renamed to misc-at24.h to reflect
> belongs to a particular subsystem?

I'm not sure about that. Having the subsystem name at the beginning of
the file doesn't seem to be a convention for all subsystems. For
instance, this is true for gpio, spi or leds, but not for hwmon.
Actually, I would stick with the corresponding subsystem naming, here:
at24.c -> at24.h.

Regards,
Vivien
