From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Sep 2014 11:00:02 +0100
Subject: [PATCH resend] arm:extend the reserved memory for initrd to be
 page aligned
In-Reply-To: <35FD53F367049845BC99AC72306C23D103D6DB49161F@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103D6DB49161F@CNBJMBX05.corpusers.net>
Message-ID: <20140919095959.GA2295@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 19, 2014 at 08:09:47AM +0100, Wang, Yalin wrote:
> this patch extend the start and end address of initrd to be page aligned,
> so that we can free all memory including the un-page aligned head or tail
> page of initrd, if the start or end address of initrd are not page
> aligned, the page can't be freed by free_initrd_mem() function.
> 
> Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(as I said, if Russell doesn't have any objections please send the patch
to his patch system)
