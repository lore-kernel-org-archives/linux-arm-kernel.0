From: matwey.kornilov@gmail.com (Matwey V. Kornilov)
Date: Fri, 29 Sep 2017 22:23:54 +0300
Subject: undefined instruction d5380001
Message-ID: <CAJs94EZqdWJRTF+tLgGU=pcRoU5HvuV959Qq8nFB5yQ-sQyxzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I am running 4.13.3 on rockchip 3328 platform(aarch64) with glibc 2.26
and see the following at booting:

[   11.152061] modprobe[93]: undefined instruction: pc=0000ffff8ca48ff4
[   11.152707] Code: d503201f 8a180320 92750001 365ffc20 (d5380001)
[   11.154347] modprobe[94]: undefined instruction: pc=0000ffff94243ff4
[   11.154991] Code: d503201f 8a180320 92750001 365ffc20 (d5380001)
[   11.157070] modprobe[97]: undefined instruction: pc=0000ffff839a0ff4
[   11.157715] Code: d503201f 8a180320 92750001 365ffc20 (d5380001)
[   11.159265] modprobe[98]: undefined instruction: pc=0000ffffb0591ff4
[   11.159908] Code: d503201f 8a180320 92750001 365ffc20 (d5380001)

As far as I understand d5380001 should be emulated in cpufeature.c but
it is not. What could be wrong here?



-- 
With best regards,
Matwey V. Kornilov
