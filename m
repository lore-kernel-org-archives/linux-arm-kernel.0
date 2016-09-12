From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Sep 2016 12:44:07 +0100
Subject: [PATCH v5 3/5] arm64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <20160912113615.GA20804@leverpostej>
References: <1473469413-11019-1-git-send-email-oss@buserror.net>
 <1473469413-11019-3-git-send-email-oss@buserror.net>
 <20160912113615.GA20804@leverpostej>
Message-ID: <20160912114406.GG23211@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2016 at 12:36:15PM +0100, Mark Rutland wrote:
> The changes in arm64's <asm/arch_timer.h> are going to conflict with
> some cleanup [1,2] that just landed in the arm64 for-next/core branch.
> 
> Could you please rebase atop of that?

Well, we should figure out what tree this is going through first. There
are a mixture of arm, arm64, driver and dts changes here and not all
of it is carrying the appropriate acks for me to queue it.

Will
