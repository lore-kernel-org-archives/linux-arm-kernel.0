From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 20 Feb 2017 14:16:13 +0100
Subject: [PATCH 2/4] Documentation: devicetree: arm: Document Marvell
 IAP140
In-Reply-To: <20170220135646.2b0219c1@free-electrons.com>
References: <20170219032000.4674-1-afaerber@suse.de>
 <20170219032000.4674-3-afaerber@suse.de>
 <20170220135646.2b0219c1@free-electrons.com>
Message-ID: <cac4ed13-5952-cccc-fee7-d9c29e77d8bb@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 20.02.2017 um 13:56 schrieb Thomas Petazzoni:
> On Sun, 19 Feb 2017 04:19:58 +0100, Andreas F?rber wrote:
> 
>> + - compatible :  must contain "mrvl,iap140"
> 
> Even though there's indeed a good number of existing "mrvl," compatible
> strings in the tree, the official vendor prefix according to
> Documentation/devicetree/bindings/vendor-prefixes.txt is "marvell".
> Probably you should use that instead for new bindings?

I'm confused now. According to Marvell IR [0] they are NASDAQ-listed as
MRVL. My understanding is that in that case the official vendor prefix
becomes mrvl. Why not here? Would be good to understand for other
pending vendors such as Actions Semi.

Any comments on the iap140 vs. pxa1908 naming? The Communication
Processors section has disappeared from marvell.com, so I couldn't
verify whether IAP140 was renamed from PXA1908 or whether both coexist
and we should add a second compatible string here?

Thanks,
Andreas

[0] http://investor.marvell.com/phoenix.zhtml?c=120802&p=irol-irhome

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
