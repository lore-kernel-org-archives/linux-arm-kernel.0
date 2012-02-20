From: armando.visconti@st.com (Armando Visconti)
Date: Mon, 20 Feb 2012 19:21:17 +0100
Subject: Question on ARM Cortex R4 support in Linux
In-Reply-To: <CAHkRjk5Be=5A1tHiRXGuQAgdLyxQDpiZwJD1ryx3T6syKaLwxg@mail.gmail.com>
References: <CAPub149OKvBUiKoOie9BmKYfopB7L0_J1fSx2Nh-aRXr99RPaQ@mail.gmail.com>
 <20120213105313.GD4994@arm.com>
 <CAPub1482HL66wX92Oc7Vu75QaweOEd3k2S757mx513GueSkurA@mail.gmail.com>
 <20120213110730.GA7375@arm.com> <4F4217F7.6050908@st.com>
 <20120220100122.GB14018@arm.com> <4F421FE4.3030106@st.com>
 <CAHkRjk5Be=5A1tHiRXGuQAgdLyxQDpiZwJD1ryx3T6syKaLwxg@mail.gmail.com>
Message-ID: <4F428F1D.3080806@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>> We are planning to buy a Cortex-R4 board from ARM.
>>>> Lionel Belnet suggested to buy Versatile + a CoreTile with Cortex-R4F
>>>> r1p2 Test Chip on it.
>>>>
>>>> Is there any Linux/ucLinux support already offered for this solution?
>>>
>>>
>>> On www.arm.com/linux there is a uClinux tab with images for download,
>>> though the kernel is 2.6.35. Anyway, you can always get a newer kernel
>>> and just disable CONFIG_MMU for a RealView/EB board with ARMv6
>>> processor.
>>
>> So, you are suggesting that we can got for a RealView + CoreTile with
>> Cortex-R4F testchip instead of versatile?
>
> I looked at the www.arm.com boards page and marketing now calls the
> RealView EB (Emulation Baseboard) a Versatile board. I lost track of
> the naming :). But yes, Versatile + R4 tile is the same as the one I
> tested. In Linux just make sure that you configure it as RealView EB.
>

Thx very much Catalin.

It is very clear and helpful from you!

Rgds,
Arm
