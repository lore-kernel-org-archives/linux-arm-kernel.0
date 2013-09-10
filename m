From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 10 Sep 2013 15:58:15 +0300
Subject: Inte IOP Xscale updates
In-Reply-To: <CACRpkdZU5mVU15AK=m-BRmpizKJJVAR98JKf3Qcgy2ms+HG+Hw@mail.gmail.com>
References: <CACRpkdZU5mVU15AK=m-BRmpizKJJVAR98JKf3Qcgy2ms+HG+Hw@mail.gmail.com>
Message-ID: <20130910125815.GB3379@blackmetal.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 03, 2013 at 02:01:45PM +0200, Linus Walleij wrote:
> I haven't really seen any functional patches or confirmation that the
> XScale machines in arch/arm/iop* are even booting since 2010 or
> so.
> 
> Can you confirm that you boot-test these machines regularly?
> 
> I am worried that we maintain code that is not used or even working
> see.

I have N2100/iop32x in use, and I also test mainline kernels regularly on
it. You don't see many patches probably because it has been very stable.
Not sure where you got the 2010, because from mailing list archives and
even from "git log" you can find booting/testing reports even from 2013.

A.
