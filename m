From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 7 Oct 2013 15:15:53 +0200
Subject: [PATCH] ARM: tlb: __flush_tlb_mm need to use int asid var for
 BE correct operation
In-Reply-To: <52529305.5050306@codethink.co.uk>
References: <1381128458-32140-1-git-send-email-victor.kamensky@linaro.org>
 <1381128458-32140-2-git-send-email-victor.kamensky@linaro.org>
 <20131007104524.GK12758@n2100.arm.linux.org.uk>
 <20131007104936.GG465@mudshark.cambridge.arm.com>
 <52529305.5050306@codethink.co.uk>
Message-ID: <20131007151553.60c0739a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ben Dooks,

On Mon, 07 Oct 2013 12:55:01 +0200, Ben Dooks wrote:

> > Speaking of which -- it's probably a good time to refresh and repost that if
> > we're aiming for 3.13...
> 
> I intended on rebasing the branch over the weekend, but ran out of
> time due to illness. I will try and look at a re-base tonight and
> if we can replace this ASID() issue then I can produce a new branch
> with it in.

Great. I remain interested in seeing the BE support merged, so if you
could Cc me on your future patch set, I could give it a test on Armada
XP hardware. It would be really nice to see it merged for 3.13.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
