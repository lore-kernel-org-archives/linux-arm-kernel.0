From: saeed.bishara@gmail.com (saeed bishara)
Date: Tue, 31 Aug 2010 16:13:28 +0300
Subject: [PATCH 2/2] set packet size limit for the mv643xx csum offloading
In-Reply-To: <20100716060856.GP14513@mail.wantstofly.org>
References: <1275827336-31111-1-git-send-email-saeed@marvell.com>
	<1275827336-31111-2-git-send-email-saeed@marvell.com>
	<20100715202621.GA772@jirafa.cyrius.com>
	<20100716060856.GP14513@mail.wantstofly.org>
Message-ID: <AANLkTiknBccMbH0ZB_bbe6xC4W1EgtFn=sxVUHCDi8cJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I noticed that patch 1/2 has gone into mainline but I cannot find 2/2
> > in any tree. ?Saeed, can you add the definition for Loki that someone
> > pointed out (9*1024) and resubmit?
>
> If you're going to supply the value explicitly for all platforms, you
> might as well supply it explicitly for mv78xx0 (9*1024) and orion5x
> (9*1024) as well.
The default value is 9*1024, so I see there is need to supply it for
mv78xx0 and Loki. agree?
saeed
