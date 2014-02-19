From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 19 Feb 2014 19:03:05 +0100
Subject: [PATCH RESEND v3] clk: return probe defer when DT clock not yet
 ready
In-Reply-To: <20140208132446.2A26694003E@smtp1-g21.free.fr>
References: <20140208132446.2A26694003E@smtp1-g21.free.fr>
Message-ID: <20140219190305.788e537d@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Nov 2013 19:47:04 +0100
Jean-Francois Moine <moinejf@free.fr> wrote:

> At probe time, a clock device may not be ready when some other device
> wants to use it.
> 
> This patch lets the functions clk_get/devm_clk_get return a probe defer
> when the clock is defined in the DT but not yet available.

Hi Mike,

Any news about this patch?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
