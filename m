From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 20 Feb 2012 10:41:56 +0000
Subject: Question on ARM Cortex R4 support in Linux
In-Reply-To: <4F421FE4.3030106@st.com>
References: <CAPub149OKvBUiKoOie9BmKYfopB7L0_J1fSx2Nh-aRXr99RPaQ@mail.gmail.com>
 <20120213105313.GD4994@arm.com>
 <CAPub1482HL66wX92Oc7Vu75QaweOEd3k2S757mx513GueSkurA@mail.gmail.com>
 <20120213110730.GA7375@arm.com> <4F4217F7.6050908@st.com>
 <20120220100122.GB14018@arm.com> <4F421FE4.3030106@st.com>
Message-ID: <20120220104156.GD14018@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2012 at 10:26:44AM +0000, Armando Visconti wrote:
> On 02/20/2012 11:01 AM, Catalin Marinas wrote:
> > On Mon, Feb 20, 2012 at 09:52:55AM +0000, Armando Visconti wrote:
> >> We are planning to buy a Cortex-R4 board from ARM.
> >> Lionel Belnet suggested to buy Versatile + a CoreTile with Cortex-R4F
> >> r1p2 Test Chip on it.
> >>
> >> Is there any Linux/ucLinux support already offered for this solution?
> >
> > On www.arm.com/linux there is a uClinux tab with images for download,
> > though the kernel is 2.6.35. Anyway, you can always get a newer kernel
> > and just disable CONFIG_MMU for a RealView/EB board with ARMv6
> > processor.
> 
> So, you are suggesting that we can got for a RealView + CoreTile with
> Cortex-R4F testchip instead of versatile?

I wasn't aware that we have a Versatile board supporting a Cortex-R4
tile. You could just mail support at arm.com and ask them to advise. I
recall I only tested with with a RealView/EB board.

> Why ARMv6?
> Maybe you meant ARMv7?

Yes, ARMv7 (ARM1156 is a v6).

-- 
Catalin
