From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 15 May 2014 12:15:59 -0600
Subject: [PATCH v2 1/3] ARM: tegra: enable MCP251x CAN controller and
 DS1307 RTC
In-Reply-To: <4cc13e0aba03a5b2d3e5f4049d252956342b1dad.1400103181.git.stefan@agner.ch>
References: <cover.1400103181.git.stefan@agner.ch>
 <4cc13e0aba03a5b2d3e5f4049d252956342b1dad.1400103181.git.stefan@agner.ch>
Message-ID: <5375045F.4030700@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2014 03:45 PM, stefan at agner.ch wrote:
> From: Stefan Agner <stefan@agner.ch>
> 
> Toradex Colibri Evaluation Board uses the DS1307 RTC and the
> MCP251x CAN controller. The NVIDIA Tegra 3 based Colibri T30
> module can be used on this carrier board, hence enable those
> drivers in tegra_defonfig.
> 
> Furthermore the NVIDIA Tegra 3 based Apalis T30 module too
> contains two MCP251x CAN controller.

I already applied v1 of this one patch.
