From: michael.weiser@gmx.de (Michael Weiser)
Date: Fri, 29 Jul 2016 09:53:43 +0200
Subject: [PATCH 2/3] stmmac: change dma descriptors to __le32
In-Reply-To: <e5229894-45fc-671e-641a-e41c7ab176d7@st.com>
References: <20160721182329.13478-1-michael.weiser@gmx.de>
 <20160721182329.13478-3-michael.weiser@gmx.de>
 <e5229894-45fc-671e-641a-e41c7ab176d7@st.com>
Message-ID: <20160729075343.GD415@weiser.dinsnail.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Giuseppe,

On Tue, Jul 26, 2016 at 02:13:45PM +0200, Giuseppe CAVALLARO wrote:

> > -			ep++;
> > +			ep++);
> there is a build problem here.
> Pls fix it.

Thanks for your review. I've got it fixed locally. An updated patchset
will be forthcoming as soon as I've sorted a problem with sun4i-emac
which I've been asked to look into as well.
-- 
Thanks,
Michael
