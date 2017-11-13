From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 13 Nov 2017 20:49:03 +0200
Subject: [PATCHv3 2/3] EDAC: ti: add support for TI keystone and DRA7xx
 EDAC
In-Reply-To: <20171113180843.hif7mfx5crvndito@pd.tnic>
References: <1510087139-21885-3-git-send-email-t-kristo@ti.com>
 <1510578490-14510-1-git-send-email-t-kristo@ti.com>
 <47e1810b-a10b-28fb-ba0e-fe28ae337c61@oracle.com>
 <20171113175816.qmvbug4kf3qu5meq@pd.tnic>
 <f9d1b261-7942-6ff6-bfc3-4b3ff22f0e27@oracle.com>
 <20171113180843.hif7mfx5crvndito@pd.tnic>
Message-ID: <cdaf8a76-c249-cd79-f03b-bfd78a5f7fbf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/11/17 20:08, Borislav Petkov wrote:
> On Mon, Nov 13, 2017 at 10:04:09AM -0800, Santosh Shilimkar wrote:
>> DTS patches can be merged anytime once its respective driver are in
>> tree.
> 
> Works for me too.
> 

I guess you can just merge the dts patch also whenever you like, as 
there is currently no support around for ti,emif-keystone. It just won't 
do anything.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
