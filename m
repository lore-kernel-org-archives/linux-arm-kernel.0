From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 31 Aug 2010 18:48:16 +0200
Subject: [PATCH 2/2] set packet size limit for the mv643xx csum offloading
In-Reply-To: <AANLkTiknBccMbH0ZB_bbe6xC4W1EgtFn=sxVUHCDi8cJ@mail.gmail.com>
References: <1275827336-31111-1-git-send-email-saeed@marvell.com>
	<1275827336-31111-2-git-send-email-saeed@marvell.com>
	<20100715202621.GA772@jirafa.cyrius.com>
	<20100716060856.GP14513@mail.wantstofly.org>
	<AANLkTiknBccMbH0ZB_bbe6xC4W1EgtFn=sxVUHCDi8cJ@mail.gmail.com>
Message-ID: <20100831164816.GU1586@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 31, 2010 at 04:13:28PM +0300, saeed bishara wrote:

> > > I noticed that patch 1/2 has gone into mainline but I cannot find 2/2
> > > in any tree. ?Saeed, can you add the definition for Loki that someone
> > > pointed out (9*1024) and resubmit?
> >
> > If you're going to supply the value explicitly for all platforms, you
> > might as well supply it explicitly for mv78xx0 (9*1024) and orion5x
> > (9*1024) as well.
>
> The default value is 9*1024, so I see there is need to supply it for
> mv78xx0 and Loki. agree?

I would supply it in any case, for clarity -- and if there are two
(or more) different values out there, then neither value really has
more right to be the default than the other.
