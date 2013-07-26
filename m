From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 26 Jul 2013 20:00:51 +0000 (UTC)
Subject: [PATCH] ARM: OMAP3EVM: Marking omap3_evm_display_init() with
 CONFIG_BROKEN
In-Reply-To: <51ED33F1.4000801@cogentembedded.com>
References: <alpine.DEB.2.02.1307220523380.4804@utopia.booyaka.com>
 <51ED33F1.4000801@cogentembedded.com>
Message-ID: <alpine.DEB.2.02.1307261956520.25740@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei

On Mon, 22 Jul 2013, Sergei Shtylyov wrote:

>    Perhaps it's better to follow what Documentation/SubmittingPatches
> suggests:
> 
> #else
> static inline __init void omap3_evm_display_init(void) {}

...

>    ... and eliminate #ifdef here?

While I agree with you in principle, the original patch is already merged.  
In my view, it's not worth checking in another patch on top of it to 
address such a cosmetic, non-functional issue.  I certainly don't think 
it's worth delaying getting v3.10-stable to boot on 37xx EVM...


- Paul
