From: huziji@marvell.com (Ziji Hu)
Date: Thu, 24 Nov 2016 18:38:19 +0800
Subject: [PATCH 5/10] dt: bindings: Add bindings for Marvell Xenon SD Host
 Controller
In-Reply-To: <20161124111029.035553ce@free-electrons.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <4031579.CBE32NHUoW@wuerfel> <877f7tmduw.fsf@free-electrons.com>
 <28082657.RK5ubAe11Q@wuerfel> <8737ihmctr.fsf@free-electrons.com>
 <CAPv3WKddPHgpRU2_tVoDF=5Z-nqfFPxjgJ-+z9o-1tR2=fFvAA@mail.gmail.com>
 <20161124111029.035553ce@free-electrons.com>
Message-ID: <f7d2ff41-5f64-e8c1-b028-dfc7aea294ae@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On 2016/11/24 18:10, Thomas Petazzoni wrote:
> Hello,
> 
> On Thu, 24 Nov 2016 10:49:23 +0100, Marcin Wojtas wrote:
> 
>> How about to avoid confusion, by simply renaming this number to
>> port-id/xenon-id or anything else but slot? I guess this may allow to
>> avoid some misunderstandings.
> 
	We borrow the term "slot" from PCIe interface from SD spec.
	According to Appendix C in SD spec 3.0, slot means an independent set of register from the view of SW.

	I can avoid using "slot" and replace "slot index" with "sdhc-id".
	Thanks for the suggestions.

	Thank you.

Best regards,
Hu Ziji

> Agreed.
> 
> Thomas
> 
