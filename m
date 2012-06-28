From: neidhard.kim@lge.com (Kim, Jong-Sung)
Date: Thu, 28 Jun 2012 15:54:49 +0900
Subject: [PATCH] [RESEND] arm: limit memblock base address for
 early_pte_alloc
In-Reply-To: <alpine.LFD.2.02.1206280223250.31003@xanadu.home>
References: <1338880312-17561-1-git-send-email-minchan@kernel.org>
 <025701cd457e$d5065410$7f12fc30$@lge.com> <20120627160220.GA2310@linaro.org>
 <00e801cd54f0$eb8a3540$c29e9fc0$@lge.com>
 <alpine.LFD.2.02.1206280223250.31003@xanadu.home>
Message-ID: <010e01cd54fa$e9c93fd0$bd5bbf70$@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Nicolas Pitre [mailto:nicolas.pitre at linaro.org]
> Sent: Thursday, June 28, 2012 3:26 PM
> 
> On Thu, 28 Jun 2012, Kim, Jong-Sung wrote:
> 
> > Thank you for your comment, Dave! It was not that sophisticated
> > choice, but I thought that normal embedded system trying to reduce the
> > BOM would have a big-enough first memblock memory region. However
> > you're right. There can be exceptional systems. Then, how do you think
> about following manner:
> [...]
> 
> This still has some possibilities for failure.
> 
Can you kindly describe the possible failure path?

> Please have a look at the two patches I've posted to fix this in a better
> way.
> 
I'm setting up for your elegant patches. ;-)
