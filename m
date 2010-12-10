From: cjb@laptop.org (Chris Ball)
Date: Fri, 10 Dec 2010 16:23:51 +0000
Subject: [PATCH] MMC: Fix multiblock SDIO transfers in AT91 MCI
In-Reply-To: <4D024D25.2000501@atmel.com>
References: <1290679911-5992-1-git-send-email-yauhen.kharuzhy@promwad.com>
	<4CEF9741.1010007@atmel.com> <4D024D25.2000501@atmel.com>
Message-ID: <20101210162351.GA11798@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Fri, Dec 10, 2010 at 04:54:13PM +0100, Nicolas Ferre wrote:
> A little "ping"!
> 
> Do you want that I re-send you the patch with relevant S-O-B lines or
> you can include them yourself?

Thanks for the ping -- I've pushed this to mmc-next and queued it for
2.6.37 now.  This looks like a candidate for the stable kernel to me;
do you agree?

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
