From: james.morse@arm.com (James Morse)
Date: Tue, 15 Dec 2015 10:18:15 +0000
Subject: [PATCH] arm64: Add missing linux/bug.h include in asm/pgtable.h
In-Reply-To: <20151214170725.GC27918@e104818-lin.cambridge.arm.com>
References: <1450109244-20122-1-git-send-email-julien.grall@citrix.com>
 <20151214162242.GA27918@e104818-lin.cambridge.arm.com>
 <566EEDC8.1050501@citrix.com>
 <20151214163840.GB27918@e104818-lin.cambridge.arm.com>
 <566EF28B.7060909@arm.com>
 <20151214170725.GC27918@e104818-lin.cambridge.arm.com>
Message-ID: <566FE8E7.4000401@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/12/15 17:07, Catalin Marinas wrote:
> If they take the mmdebug.h patch, it's even better. Please let us know
> how that goes.


Andrew Morton's Robot wrote:
> The patch titled
>      Subject: include/linux/mmdebug.h: should include linux/bug.h
> has been added to the -mm tree.  Its filename is
>      include-linux-mmdebugh-should-include-linux-bugh.patch
> 
> This patch should soon appear at
>     http://ozlabs.org/~akpm/mmots/broken-out/include-linux-mmdebugh-should-include-linux-bugh.patch
> and later at
>     http://ozlabs.org/~akpm/mmotm/broken-out/include-linux-mmdebugh-should-include-linux-bugh.patch
> 
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
> 
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
> 
> The -mm tree is included into linux-next and is updated
> there every 3-4 working days




Thanks,

James
