From: timur@freescale.com (Timur Tabi)
Date: Mon, 27 Feb 2012 14:31:01 -0600
Subject: [PATCH 2/6] ASoC: fsl: align mpc8610_hpcd with p1022_ds on getting
 codec node
In-Reply-To: <1330092582-21180-3-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <4F4BE805.1070208@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> Align mpc8610_hpcd with p1022_ds on getting codec node by just calling
> of_parse_phandle.  The bonus point of doing that is we can save
> exporting get_node_by_phandle_name() when we consolidate the common
> bits between mpc8610_hpcd and p1022_ds into a module, which can be
> shared by more machine drivers added later.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
