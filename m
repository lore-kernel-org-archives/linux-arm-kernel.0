From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 1 Aug 2018 13:50:27 -0700
Subject: next/master boot: 179 boots: 11 failed, 167 passed with 1
 offline (next-20180731)
In-Reply-To: <20180801093102.GB5509@sirena.org.uk>
References: <5b607cc4.1c69fb81.6c1d6.6534@mx.google.com>
 <20180731161114.GI5719@sirena.org.uk>
 <20180731195037.GA6737@centauri.lan>
 <20180801093102.GB5509@sirena.org.uk>
Message-ID: <20180801205027.GC24465@builder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 01 Aug 02:31 PDT 2018, Mark Brown wrote:

> On Tue, Jul 31, 2018 at 09:50:37PM +0200, Niklas Cassel wrote:
> 
> > I guess it could be a bug that does not trigger on every boot,
> > or it could be a problem in the kernelci infrastructure.
> 
> Infrastructure bugs *tend* to manifest differently to this FWIW, though
> it can never be excluded.

No, that's not an infrastructure issue.

The board did warn about not finding the ath10k firmware, which is
always does, so that's not the issue - in itself. Then nothing happened
for 266 seconds, so my lab decided to terminate the agony.

So this is either an issue with the stability of next-20180731 or with
the specific board.


PS. Today's next did boot successfully on the board.

Regards,
Bjorn
