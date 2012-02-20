From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 20 Feb 2012 10:01:22 +0000
Subject: Question on ARM Cortex R4 support in Linux
In-Reply-To: <4F4217F7.6050908@st.com>
References: <CAPub149OKvBUiKoOie9BmKYfopB7L0_J1fSx2Nh-aRXr99RPaQ@mail.gmail.com>
 <20120213105313.GD4994@arm.com>
 <CAPub1482HL66wX92Oc7Vu75QaweOEd3k2S757mx513GueSkurA@mail.gmail.com>
 <20120213110730.GA7375@arm.com> <4F4217F7.6050908@st.com>
Message-ID: <20120220100122.GB14018@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2012 at 09:52:55AM +0000, Armando Visconti wrote:
> >>>> Has anybody used it on Cortex R4 based platform ?
> >>>
> >>> In theory Linux support for R4 should just work (once CONFIG_MMU is
> >>> disabled). I used to test it in the past regularly but not recently.
> >>
> >> Great. I was planning to use linux-3.2, I hope the support is there ?
> >
> > It's been there for years, but some bit-rotting may have occurred.
> 
> I'm assuming you have tried it on a FPGA solution, is that correct?

It may have been a real silicon (core tile for a RealView EB board), I
don't remember the details.

> We are planning to buy a Cortex-R4 board from ARM.
> Lionel Belnet suggested to buy Versatile + a CoreTile with Cortex-R4F
> r1p2 Test Chip on it.
> 
> Is there any Linux/ucLinux support already offered for this solution?

On www.arm.com/linux there is a uClinux tab with images for download,
though the kernel is 2.6.35. Anyway, you can always get a newer kernel
and just disable CONFIG_MMU for a RealView/EB board with ARMv6
processor.

> Any other idea?

I can't really tell what other R4 platforms are around.

-- 
Catalin
