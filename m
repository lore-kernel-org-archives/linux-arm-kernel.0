From: b-cousson@ti.com (Benoit Cousson)
Date: Wed, 4 Jul 2012 18:14:45 +0200
Subject: [PATCHv2 02/12] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
In-Reply-To: <87mx3f38lh.fsf@ti.com>
References: <20120611004502.20034.8840.stgit@dusk>
 <20120611004555.20034.87035.stgit@dusk> <4FDA15AA.6090704@ti.com>
 <alpine.DEB.2.00.1206141136080.30212@utopia.booyaka.com>
 <4FDA45F5.9090300@ti.com>
 <alpine.DEB.2.00.1206141706420.25628@utopia.booyaka.com>
 <4FDB387C.7030003@ti.com>
 <alpine.DEB.2.00.1207040625090.6760@utopia.booyaka.com>
 <alpine.DEB.2.00.1207040652240.6760@utopia.booyaka.com>
 <87mx3f38lh.fsf@ti.com>
Message-ID: <4FF46BF5.50308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On 07/04/2012 04:27 PM, Kevin Hilman wrote:

[...]

> Tested-by: Kevin Hilman <khilman@ti.com>
> 
> I confirm this version is now allowing CORE to hit retention during
> suspend.
> 
> Benoit, I hope this is OK with you.  We need a fix for this in v3.5
> since this is last core bug preventing CORE retention in v3.5.

On OMAP4 as well? I've just tried with the hwmod fix for AESS and USB
and still cannot reach RET.

Am I missing some other patches for OMAP4?

Regards,
Benoit
