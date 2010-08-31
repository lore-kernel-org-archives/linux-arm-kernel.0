From: saeed.bishara@gmail.com (saeed bishara)
Date: Tue, 31 Aug 2010 14:17:34 +0300
Subject: [PATCH 2/2] set packet size limit for the mv643xx csum offloading
In-Reply-To: <20100716060856.GP14513@mail.wantstofly.org>
References: <1275827336-31111-1-git-send-email-saeed@marvell.com>
	<1275827336-31111-2-git-send-email-saeed@marvell.com>
	<20100715202621.GA772@jirafa.cyrius.com>
	<20100716060856.GP14513@mail.wantstofly.org>
Message-ID: <AANLkTi=pqe7-1UzzsK8zQ8Dfvmr-usxELHkH_aVqQQ9C@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 16, 2010 at 9:08 AM, Lennert Buytenhek
<buytenh@wantstofly.org>wrote:

> On Thu, Jul 15, 2010 at 09:26:21PM +0100, Martin Michlmayr wrote:
>
> > > The mv643xx ethernet controller limits the packet size for the TX
> > > checksum offloading. this patch sets this limits for the needed
> > > devices.
> >
> > I noticed that patch 1/2 has gone into mainline but I cannot find 2/2
> > in any tree.  Saeed, can you add the definition for Loki that someone
> > pointed out (9*1024) and resubmit?
>
> If you're going to supply the value explicitly for all platforms, you
> might as well supply it explicitly for mv78xx0 (9*1024) and orion5x
> (9*1024) as well.
>
The default value is 9*1024, so I see there is need to supply it for mv78xx0
and Loki. agree?
saeed

> --
> To unsubscribe from this list: send the line "unsubscribe linux-net" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100831/5a9974d1/attachment-0001.html>
