From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Feb 2012 07:33:01 +0000
Subject: [PATCH 04/18] ARM: at91: make ST (System Timer) soc independent
In-Reply-To: <20120220030234.GE29599@game.jcrosoft.org>
References: <1329501010-30468-1-git-send-email-nicolas.ferre@atmel.com>
 <957702b1ff83afcc0a8e842f53f05ff3f40b78b3.1329500622.git.nicolas.ferre@atmel.com>
 <4F419246.6080405@gmail.com> <20120220013825.GD29599@game.jcrosoft.org>
 <4F41A76D.1070409@gmail.com> <20120220030234.GE29599@game.jcrosoft.org>
Message-ID: <20120220073301.GA22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2012 at 04:02:34AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 12:52 Mon 20 Feb     , Ryan Mallon wrote:
> > That isn't an excuse to leave incorrect code there. It is a simple fix.
> no (void) in c means you don't care of the return so basically it's right

Let's be clear: it's legal, but redundant and unnecessary.
