From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 22 Sep 2015 20:57:52 +0530
Subject: [PATCH] ARM: davinci: clock: Correct return values for API
 functions
In-Reply-To: <1442222979-9703-1-git-send-email-peter.ujfalusi@ti.com>
References: <1442222979-9703-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <56017378.5060503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 September 2015 02:59 PM, Peter Ujfalusi wrote:
> Fix the values returned by the publicly used functions.
> These function should return 0 when they are called with clk == NULL in
> similar manner as the clock API does to avoid different behavior in drivers
> used by daVinci and other architectures.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
> Hi Sekhar,
> 
> This issue is visible when using generic drivers like ASoC simnple card for
> audio support.
> They rely on the fact that these functions will not return with error in case
> of clk == NULL.

Looks good. Will queue for v4.4. Some of the information below the tear
line could go into the commit text too, I think.

Thanks,
Sekhar
