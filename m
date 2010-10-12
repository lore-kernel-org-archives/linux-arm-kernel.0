From: cjb@laptop.org (Chris Ball)
Date: Tue, 12 Oct 2010 03:59:46 +0100
Subject: [PATCH v5 2/2] sdhci-s3c: Add support no internal clock
	divider in host controller
In-Reply-To: <AANLkTinC850pde5Diuz5U40RCDGR1DeQzTAfLUHWm0rB@mail.gmail.com>
References: <1286783400-7277-1-git-send-email-kgene.kim@samsung.com>
	<AANLkTinC850pde5Diuz5U40RCDGR1DeQzTAfLUHWm0rB@mail.gmail.com>
Message-ID: <20101012025946.GA8534@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kyungmin,

On Tue, Oct 12, 2010 at 11:53:35AM +0900, Kyungmin Park wrote:
> Hi Chris,
> 
> we make a conclusion use this patch. Can you merge it for 2.6.37?
> 
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

I don't feel that I can, because Ben Dooks is listed as the maintainer
for this driver and the patch does not have his ACK.

I don't know what to do about this; I've already tried asking Ben
whether he intends to continue maintaining sdhci-s3c, with no reply.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
