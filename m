From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Mar 2012 20:42:34 -0600
Subject: [PATCH v4 07/10] pwm: tegra: Add device tree support
In-Reply-To: <1331740593-10807-8-git-send-email-thierry.reding@avionic-design.de>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-8-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <4F67EE9A.6080101@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2012 09:56 AM, Thierry Reding wrote:
> Add auxdata to instantiate the PWFM controller from a device tree,
> include the corresponding nodes in the dtsi files for Tegra 20 and
> Tegra 30 and add binding documentation.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

> +++ b/Documentation/devicetree/bindings/pwm/tegra-pwm.txt

Can this please be named nvidia,tegra20-pwm.txt so that if we need
different bindings for any future Tegra PWM, we won't have any filename
conflicts?

Aside from that,

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
