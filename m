From: s-anna@ti.com (Suman Anna)
Date: Tue, 1 Mar 2016 10:55:54 -0600
Subject: [PATCH v3 3/3] pci: dra7xx: use pdata callbacks to perform reset
In-Reply-To: <56D5834C.5030800@ti.com>
References: <1452780672-14339-1-git-send-email-kishon@ti.com>
 <20160127173104.GQ19432@atomide.com> <56A90971.4020409@ti.com>
 <20160127185649.GV19432@atomide.com> <56A94FB7.6020903@ti.com>
 <20160128183156.GH19432@atomide.com> <56B087AD.4000505@ti.com>
 <alpine.DEB.2.02.1602080208070.2182@utopia.booyaka.com>
 <56B900E9.9040306@ti.com>
 <alpine.DEB.2.02.1602090846480.2906@utopia.booyaka.com>
 <56BA2495.9020407@ti.com>
 <alpine.DEB.2.02.1602091932160.2906@utopia.booyaka.com>
 <56BA958A.1020503@ti.com> <56BACCDB.2070507@ti.com>
 <alpine.DEB.2.02.1602111921090.20757@utopia.booyaka.com>
 <56BD8091.4090007@ti.com> <56BE1454.3030002@ti.com> <56C5D377.50901@ti.com>
 <56CAA82D.6000507@ti.com>
 <alpine.DEB.2.02.1602220631300.3418@utopia.booyaka.com>
 <56CADB23.8020202@ti.com> <56CC490F.3040301@ti.com>
 <alpine.DEB.2.02.1602231827300.27173@utopia.booyaka.com>
 <56CD4BE1.3010701@ti.com>
 <alpine.DEB.2.02.1603010825090.14948@utopia.booyaka.com>
 <56D5834C.5030800@ti.com>
Message-ID: <56D5C99A.1050109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2016 05:55 AM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Tuesday 01 March 2016 01:55 PM, Paul Walmsley wrote:
>>
>> Folks, the following is what I've queued for this.
> 
> Thanks Paul.
> 
> Bjorn,
> 
> With this patch merged, enabling pci-dra7xx won't result in system freeze
> anymore. I can send a patch to revert depends on BROKEN.

Kishon,
Make sure you send only that after both this patch and the pcie reset
data are in. I see the pcie reset data in Paul's for-4.6 branch.

regards
Suman

[snip]
