From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 13 Feb 2012 10:53:13 +0000
Subject: Question on ARM Cortex R4 support in Linux
In-Reply-To: <CAPub149OKvBUiKoOie9BmKYfopB7L0_J1fSx2Nh-aRXr99RPaQ@mail.gmail.com>
References: <CAPub149OKvBUiKoOie9BmKYfopB7L0_J1fSx2Nh-aRXr99RPaQ@mail.gmail.com>
Message-ID: <20120213105313.GD4994@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 10:49:18AM +0000, shiraz hashim wrote:
> We plan to use Linux on our Cortex R4 based SoC.
> Can we use the latest Linux straight away or do we
> require to add some support for it.
> 
> I went through www.linux-arm.org/LinuxKernel/LinuxM3
> which describes Cortex M3 support in Linux but was not
> able to find any information on M4.

Do you mean M4 or R4 here?

> Has anybody used it on Cortex R4 based platform ?

In theory Linux support for R4 should just work (once CONFIG_MMU is
disabled). I used to test it in the past regularly but not recently.

-- 
Catalin
