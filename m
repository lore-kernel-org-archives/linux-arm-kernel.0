From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Fri, 16 Jul 2010 08:08:56 +0200
Subject: [PATCH 2/2] set packet size limit for the mv643xx csum offloading
In-Reply-To: <20100715202621.GA772@jirafa.cyrius.com>
References: <1275827336-31111-1-git-send-email-saeed@marvell.com>
	<1275827336-31111-2-git-send-email-saeed@marvell.com>
	<20100715202621.GA772@jirafa.cyrius.com>
Message-ID: <20100716060856.GP14513@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 15, 2010 at 09:26:21PM +0100, Martin Michlmayr wrote:

> > The mv643xx ethernet controller limits the packet size for the TX
> > checksum offloading. this patch sets this limits for the needed
> > devices.
> 
> I noticed that patch 1/2 has gone into mainline but I cannot find 2/2
> in any tree.  Saeed, can you add the definition for Loki that someone
> pointed out (9*1024) and resubmit?

If you're going to supply the value explicitly for all platforms, you
might as well supply it explicitly for mv78xx0 (9*1024) and orion5x
(9*1024) as well.
