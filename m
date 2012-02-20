From: armando.visconti@st.com (Armando Visconti)
Date: Mon, 20 Feb 2012 10:52:55 +0100
Subject: Question on ARM Cortex R4 support in Linux
In-Reply-To: <20120213110730.GA7375@arm.com>
References: <CAPub149OKvBUiKoOie9BmKYfopB7L0_J1fSx2Nh-aRXr99RPaQ@mail.gmail.com>
 <20120213105313.GD4994@arm.com>
 <CAPub1482HL66wX92Oc7Vu75QaweOEd3k2S757mx513GueSkurA@mail.gmail.com>
 <20120213110730.GA7375@arm.com>
Message-ID: <4F4217F7.6050908@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ciao Catalin,


>>>> Has anybody used it on Cortex R4 based platform ?
>>>
>>> In theory Linux support for R4 should just work (once CONFIG_MMU is
>>> disabled). I used to test it in the past regularly but not recently.
>>
>> Great. I was planning to use linux-3.2, I hope the support is there ?
>
> It's been there for years, but some bit-rotting may have occurred.
>

I'm assuming you have tried it on a FPGA solution, is that correct?

We are planning to buy a Cortex-R4 board from ARM.
Lionel Belnet suggested to buy Versatile + a CoreTile with Cortex-R4F
r1p2 Test Chip on it.

Is there any Linux/ucLinux support already offered for this solution?
Any other idea?

Thx,
Arm


-- 
-- "Every step appears to be the unavoidable consequence of the
-- preceding one." (A. Einstein)
-- 
Armando Visconti                  Mobile: (+39) 346 8879146
Senior SW Engineer                Fax:    (+39) 02 93519290
CPG                               Work:   (+39) 02 93519683
Computer System Division          e-mail: armando.visconti at st.com
ST Microelectronics               TINA:   051  4683
