From: dan.j.williams@intel.com (Dan Williams)
Date: Fri, 14 Jan 2011 16:23:36 -0800
Subject: [PATCH] dmaengine i.MX SDMA: Fix firmware loading
In-Reply-To: <1294827494-15092-2-git-send-email-s.hauer@pengutronix.de>
References: <1294827494-15092-1-git-send-email-s.hauer@pengutronix.de>
	<1294827494-15092-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <AANLkTi=zi1uLm4w-=rBmLseWf0GD6kJJHngD8Shpacar@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 12, 2011 at 2:18 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> When loading the microcode to the SDMA engine we have to use
> the ram_code_start_addr found in the firmware image. The copy
> in the sdma engine is not initialized correctly. This is broken
> since:
> 5b28aa3 dmaengine i.MX SDMA: Allow to run without firmware
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---

I'll apply this to my 'fixes' branch once I rebase on top of rc1.

--
Dan
