From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 13 May 2013 11:59:51 -0400
Subject: [PATCHv1 0/5] Marvell EBU irqchip improvements
In-Reply-To: <20130415194825.GT28693@titan.lakedaemon.net>
References: <1365542778-27959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130415194825.GT28693@titan.lakedaemon.net>
Message-ID: <20130513155951.GN31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 03:48:25PM -0400, Jason Cooper wrote:
> On Tue, Apr 09, 2013 at 11:26:13PM +0200, Thomas Petazzoni wrote:
...
> > Thomas Petazzoni (5):
...
> >   ARM: mvebu: do not duplicate the mpic alias
> 
> I already sent the PR for LPAE, which will conflict with this.  I'll add
> this to mvebu/fixes once v3.9 drops.

Obviously, I meant v3.10-rc1.  mvebu-next/fixes is now mvebu/fixes,
rebased onto v3.10-rc1.  This patch is included.

thx,

Jason.
