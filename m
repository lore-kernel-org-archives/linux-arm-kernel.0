From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 13 May 2014 13:57:14 -0600
Subject: [PATCH 1/2] ARM: tegra: enable MCP251x CAN controller and DS1307
 RTC
In-Reply-To: <77cfca0a1769d867c8d2919f0040fbd785940fef.1400001937.git.stefan@agner.ch>
References: <cover.1400001937.git.stefan@agner.ch>
 <77cfca0a1769d867c8d2919f0040fbd785940fef.1400001937.git.stefan@agner.ch>
Message-ID: <5372791A.4080909@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2014 11:27 AM, stefan at agner.ch wrote:
> From: Stefan Agner <stefan@agner.ch>
> 
> Toradex Colibri Evaluation Board uses the DS1307 RTC and the
> MCP251x CAN controller. The NVIDIA Tegra 3 based Colibri T30
> module can be used on this carrier board, hence enable those
> drivers in tegra_defonfig.
> 
> Furthermore the NVIDIA Tegra 3 based Apalis T30 module too
> contains two MCP251x CAN controller.

I have squashed this patch into Tegra's for-3.16/defconfig branch.

Can you please also send a patch to enable the same options in
multi_v7_defconfig. Send that to arm at kernel.org (it's an alias for the
armsoc tree maintainers). That will ensure that anyone using that config
will also get these changes.

Thanks.
