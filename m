From: claude.youn@gmail.com (Seungwhan Youn)
Date: Tue, 12 Oct 2010 12:25:03 +0900
Subject: [alsa-devel] [PATCH 10/10] ASoC: SAMSUNG: Add Machine driver for
	S/PDIF PCM audio
In-Reply-To: <AANLkTi=NrEm8XHWbD6UxrxxAeCtTrdwr9_KYNSBv5+nm@mail.gmail.com>
References: <AANLkTincwL_nQAmu7Dcmht0FV43BiN7OoecE_60QJhS2@mail.gmail.com>
	<20101005044304.GA26509@opensource.wolfsonmicro.com>
	<AANLkTi=x_fi5HTBBmMUv8YTxSdbgcnJ=ZbacJQj6rcgf@mail.gmail.com>
	<20101005055937.GA19989@opensource.wolfsonmicro.com>
	<AANLkTimi1t5S2XWdUFzaPttD4Hywm0SLt5CvR1YnVOjj@mail.gmail.com>
	<AANLkTin4skx+aiL2FXwWO1ekKqT2YWDd3SM1H5WnGkhC@mail.gmail.com>
	<00c401cb6520$9484ef90$bd8eceb0$%kim@samsung.com>
	<AANLkTikf4CAWm49Q_AfcfiQDBQUVcE_BC-a_4F7d8xOz@mail.gmail.com>
	<AANLkTinPXcjHcaM1puzz00Sfhob9Y-X4HGDDVGMTqhH5@mail.gmail.com>
	<AANLkTindvBBOyWwkbwUo+oG31r8xSgCLbjuDNgvTNY_Q@mail.gmail.com>
	<20101011104737.GB16777@sirena.org.uk>
	<AANLkTi=NrEm8XHWbD6UxrxxAeCtTrdwr9_KYNSBv5+nm@mail.gmail.com>
Message-ID: <AANLkTimp0WB+vweX8-pMVZZeHN6nD401TtkJyNthCEO5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> I'm OK with having the code in the driver, I just want something there
>> that makes it more discoverable that it's there like a config option.
>> Having the driver log loudly when it reconfigures the EPLL would
>> probably also cover it.
>
> Thanks. Yes, we should print warning upon changing EPLL.

Okay, I'll fix this also and will re-submit today. :-)
