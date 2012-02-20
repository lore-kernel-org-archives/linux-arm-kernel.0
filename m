From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 20 Feb 2012 10:18:09 +0100
Subject: [PATCH 04/18] ARM: at91: make ST (System Timer) soc independent
In-Reply-To: <20120220073301.GA22562@n2100.arm.linux.org.uk>
References: <1329501010-30468-1-git-send-email-nicolas.ferre@atmel.com>
 <957702b1ff83afcc0a8e842f53f05ff3f40b78b3.1329500622.git.nicolas.ferre@atmel.com>
 <4F419246.6080405@gmail.com>
 <20120220013825.GD29599@game.jcrosoft.org>
 <4F41A76D.1070409@gmail.com>
 <20120220030234.GE29599@game.jcrosoft.org>
 <20120220073301.GA22562@n2100.arm.linux.org.uk>
Message-ID: <20120220091809.GB28066@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07:33 Mon 20 Feb     , Russell King - ARM Linux wrote:
> On Mon, Feb 20, 2012 at 04:02:34AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 12:52 Mon 20 Feb     , Ryan Mallon wrote:
> > > That isn't an excuse to leave incorrect code there. It is a simple fix.
> > no (void) in c means you don't care of the return so basically it's right
> 
> Let's be clear: it's legal, but redundant and unnecessary.
So as I said it's no the focus of this patch

I don't want to do it at the same time

Best Regards,
J.
