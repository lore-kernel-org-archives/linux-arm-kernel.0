From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Mar 2011 15:59:30 -0000
Subject: [PATCH v3 0/7] Migrate GIC to fasteoi flow control
In-Reply-To: <1299604405-12960-1-git-send-email-will.deacon@arm.com>
References: <1299604405-12960-1-git-send-email-will.deacon@arm.com>
Message-ID: <000301cbe005$4ea20390$ebe60ab0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* I wrote:
 
> Hello,
> 
> This is version 3 of the patch series originally posted here:
> 
> v1.) http://lists.infradead.org/pipermail/linux-arm-kernel/2011-February/043083.html
> v2.) http://lists.infradead.org/pipermail/linux-arm-kernel/2011-February/043984.html
> 
> Changes since v2:
> 
> 	* Added chained_irq_{enter,exit} functions to work with chained
> 	  handlers that support multiple primary chips and to aid in
> 	  bisectibility
> 	* Based on 2.6.38-rc8
> 
> As a result of these changes, all of the BSP code has been reworked so
> I'm afraid I need some fresh acks and tested-bys because the old ones
> are no longer valid.
> 
> I appreciate there is some debate concerning the sanity of chained
> handlers with potentially multiple primary chips, but I can't think of
> a way to fix these without considering the handlers on a case-by-case
> basis which is not the intent of this patch series.

Well, I've not had any feedback on this lot but I'd like to
get the first patch merged so that the rest of it can go in
easily with no ordering dependencies.

Any comments on the first patch are more than welcome.

Will
