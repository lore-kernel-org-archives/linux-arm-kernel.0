From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 14 Dec 2013 22:15:19 +0800
Subject: [PATCH] ARM: imx6: Derive spdif clock from pll3_pfd3_454m
In-Reply-To: <1386949072-6520-1-git-send-email-Guangyu.Chen@freescale.com>
References: <1386949072-6520-1-git-send-email-Guangyu.Chen@freescale.com>
Message-ID: <20131214141518.GF16177@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 11:37:52PM +0800, Nicolin Chen wrote:
> SPDIF can derive a TX clock for playback from one of its clock sources --
> spdif root clock to match its supporting sample rates. So this patch set
> the spdif root clock's parent to pll3_pfd3_454m since the pll3_pfd3_454m
> can approximately meet its sample rate requirement.
> 
> Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>

Applied, thanks.
