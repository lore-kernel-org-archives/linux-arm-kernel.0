From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 12 Oct 2010 14:37:00 -0700
Subject: [PATCH v5 2/2] sdhci-s3c: Add support no internal clock divider
	in host controller
In-Reply-To: <20101012025946.GA8534@void.printf.net>
References: <1286783400-7277-1-git-send-email-kgene.kim@samsung.com>
	<AANLkTinC850pde5Diuz5U40RCDGR1DeQzTAfLUHWm0rB@mail.gmail.com>
	<20101012025946.GA8534@void.printf.net>
Message-ID: <20101012143700.93ea1812.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Oct 2010 03:59:46 +0100
Chris Ball <cjb@laptop.org> wrote:

> Hi Kyungmin,
> 
> On Tue, Oct 12, 2010 at 11:53:35AM +0900, Kyungmin Park wrote:
> > Hi Chris,
> > 
> > we make a conclusion use this patch. Can you merge it for 2.6.37?
> > 
> > Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> I don't feel that I can, because Ben Dooks is listed as the maintainer
> for this driver and the patch does not have his ACK.
> 
> I don't know what to do about this; I've already tried asking Ben
> whether he intends to continue maintaining sdhci-s3c, with no reply.
> 

People get busy and take vacations and change roles, etc.

Sometimes, the best you can do is to make everyone aware of what's
going on and then simply proceed on your own.
