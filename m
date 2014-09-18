From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 18 Sep 2014 17:04:34 +0100
Subject: [PATCH Resend] arm:extend the reserved mrmory for initrd to be
 page aligned
In-Reply-To: <35FD53F367049845BC99AC72306C23D103D6DB491619@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103D6DB491616@CNBJMBX05.corpusers.net>
 <20140918055553.GO3755@pengutronix.de>
 <35FD53F367049845BC99AC72306C23D103D6DB491619@CNBJMBX05.corpusers.net>
Message-ID: <20140918160434.GC25330@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 18, 2014 at 07:53:57AM +0100, Wang, Yalin wrote:
> This patch extends the start and end address of initrd to be page aligned,
> so that we can free all memory including the un-page aligned head or tail
> page of initrd, if the start or end address of initrd are not page
> aligned, the page can't be freed by free_initrd_mem() function.
> 
> Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>

You still have a typo in the subject.

For the arm64 part:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

so you can merge it via Russell's patch system.
