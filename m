From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 9 Jun 2016 20:11:50 +0200 (CEST)
Subject: [PATCH 1/2] DT: bindings: remove bcm2835-sdhci
In-Reply-To: <5751E1F1.5020202@wwwdotorg.org>
References: <1464983233-27001-1-git-send-email-stefan.wahren@i2se.com>
 <1464983233-27001-2-git-send-email-stefan.wahren@i2se.com>
 <5751E1F1.5020202@wwwdotorg.org>
Message-ID: <1995060523.43076.c268f06d-da3c-427e-800f-fbc65895c323.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

> Stephen Warren <swarren@wwwdotorg.org> hat am 3. Juni 2016 um 22:00
> geschrieben:
> 
> 
> On 06/03/2016 01:47 PM, Stefan Wahren wrote:
> > The sdhci-iproc also supports bcm2835. So this binding is obsolete.
> 
> sdhci-iproc supports this binding, so I don't believe the binding is 
> obsolete. The duplicate implementations (drivers) can possibly be 
> removed, but not the binding doc, which is (or at least could be) still 
> in use.

sorry for my late reply.

So the brcm,bcm2835-sdhci.txt must be kept, even if the compatible string
"brcm,bcm2835-sdhci" has been added to brcm,sdhci-iproc.txt?

Do i need to send a new version of this series?

Stefan

> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
