From: peron.clem@gmail.com (=?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?=)
Date: Thu, 4 Oct 2018 11:24:51 +0200
Subject: [PATCH 3/3] ARM: socfpga: Turn on ARM errata for L2 cache
In-Reply-To: <20181004091632.GA30658@n2100.armlinux.org.uk>
References: <20181004085415.12925-1-peron.clem@gmail.com>
 <20181004085415.12925-3-peron.clem@gmail.com>
 <20181004091632.GA30658@n2100.armlinux.org.uk>
Message-ID: <CAJiuCcd3ANzX63X+ZtGFeeeEKdWPS6b=YhF4KKyBZgA3L0AxNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 4 Oct 2018 at 11:16, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Thu, Oct 04, 2018 at 10:54:15AM +0200, Cl?ment P?ron wrote:
> > From: Dinh Nguyen <dinguyen@kernel.org>
> >
> > Turn on these ARM and PL310 errata for SoCFPGA:
> >
> > ARM_ERRATA_754322
> > ARM_ERRATA_764369
> > ARM_ERRATA_775420
> >
> > PL310_ERRATA_588369
> > PL310_ERRATA_727915
> > PL310_ERRATA_753970
> > PL310_ERRATA_769419
> >
> > Fixes: 387798b37c8d ("ARM: initial multiplatform support")
>
> What was broken in the referred to commit that caused this regression?
> If it's not a regression, why does it have a Fixes: line?

Sorry I'm not familiar with the "Fixes" tag, I though it was required
to be backported on the stable branch.
I will remove it in the v2

Thanks,
Cl?ment
