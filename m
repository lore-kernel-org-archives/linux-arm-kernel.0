From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 11 Jul 2011 15:29:00 +0800
Subject: [GIT PULL] pxa: patches for v3.1
In-Reply-To: <201107061857.51896.arnd@arndb.de>
References: <CAMPhdO-Xy69r5P-GZivUjsho81k1b_m_mAYM2hxtBt2X3W=42A@mail.gmail.com>
	<201107061857.51896.arnd@arndb.de>
Message-ID: <CAMPhdO-3DJq_sR6q-V7khSBhp=_yMrs2s6LTC2zU=szK1cosMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Eric Miao (7):
>> ? ? ? ARM: pxa: enable AUTO_ZRELADDR
>> ? ? ? ARM: pxa: add common header file for pxa3xx
>> ? ? ? ARM: pxa: move declarations from generic.h to <soc>.h

Hi Arnd,

I've put these three patches to the features branch (-devel) instead of
cleanup. As the first enabled something, the 2nd/3rd are actually part
of the MULTI_IRQ patch series.

>> ? ? ? ARM: pxa/saarb: make use of pxa3xx_map_io()
