From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 14 Oct 2010 15:17:59 +0100
Subject: [PATCH 2/3] ARM: S5PV210: Add init code of audio to Goni and
	Aquila board
In-Reply-To: <AANLkTin4pHDMT1Cq_7Wf_P57wEvB28UZt601Y09EY-Pg@mail.gmail.com>
References: <4CA5623B.5030405@samsung.com>
	<003701cb6b37$4c106fb0$e4314f10$%kim@samsung.com>
	<AANLkTimwNprWtZiMnAt2-fYGwRySs-mbxxh-TYSqh=f6@mail.gmail.com>
	<AANLkTimqBgUuVzhV84HKGUygNB2raebrgTrEeKnd3uQc@mail.gmail.com>
	<AANLkTin4pHDMT1Cq_7Wf_P57wEvB28UZt601Y09EY-Pg@mail.gmail.com>
Message-ID: <20101014141758.GB8991@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 14, 2010 at 10:17:11AM +0900, Jassi Brar wrote:

> > It's not exactly. GPIO pins are different.

> Maybe the GPIO differences could be handled at one place and other codes
> compressed ?

Platform data for the audio driver, perhaps?  That's being used by some
other systems, and should be much easier now with multi-component.
