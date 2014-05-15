From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 15 May 2014 12:14:18 -0600
Subject: [PATCH] ARM: add drivers for Colibri T30 to multi_v7_defconfig
In-Reply-To: <1400103110-17574-1-git-send-email-stefan@agner.ch>
References: <1400103110-17574-1-git-send-email-stefan@agner.ch>
Message-ID: <537503FA.5070605@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2014 03:31 PM, stefan at agner.ch wrote:
> From: Stefan Agner <stefan@agner.ch>
> 
> Toradex Colibri Evaluation Board uses the DS1307 RTC and the
> MCP251x CAN controller. The NVIDIA Tegra 3 based Colibri T30
> module can be used on this carrier board, hence enable those
> drivers in tegra_defonfig and multi_v7_defconfig.
> 
> Furthermore the NVIDIA Tegra 3 based Apalis T30 module too
> contains two MCP251x CAN controller.

Acked-by: Stephen Warren <swarren@nvidia.com>
