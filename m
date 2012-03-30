From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 30 Mar 2012 12:57:18 -0600
Subject: [PATCH v5 08/16] pwm: Add NVIDIA Tegra SoC support
In-Reply-To: <1332945238-14897-9-git-send-email-thierry.reding@avionic-design.de>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
 <1332945238-14897-9-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <4F76020E.30207@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2012 08:33 AM, Thierry Reding wrote:
> This commit adds a generic PWM framework driver for the PWFM controller
> found on NVIDIA Tegra SoCs. The driver is based on code from the
> Chromium kernel tree and was originally written by Gary King (NVIDIA)
> and later modified by Simon Que (Chromium).
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
