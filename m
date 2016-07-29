From: peppe.cavallaro@st.com (Giuseppe CAVALLARO)
Date: Fri, 29 Jul 2016 10:26:24 +0200
Subject: [PATCH 2/3] stmmac: change dma descriptors to __le32
In-Reply-To: <20160729075343.GD415@weiser.dinsnail.net>
References: <20160721182329.13478-1-michael.weiser@gmx.de>
 <20160721182329.13478-3-michael.weiser@gmx.de>
 <e5229894-45fc-671e-641a-e41c7ab176d7@st.com>
 <20160729075343.GD415@weiser.dinsnail.net>
Message-ID: <9d83a435-eff1-a2d3-0d3d-158503564425@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/29/2016 9:53 AM, Michael Weiser wrote:
> Hi Giuseppe,
>
> On Tue, Jul 26, 2016 at 02:13:45PM +0200, Giuseppe CAVALLARO wrote:
>
>>> -			ep++;
>>> +			ep++);
>> there is a build problem here.
>> Pls fix it.
>
> Thanks for your review. I've got it fixed locally. An updated patchset
> will be forthcoming as soon as I've sorted a problem with sun4i-emac
> which I've been asked to look into as well.
>

ok, as you send the new version I will do a run on ARM box based too

peppe
