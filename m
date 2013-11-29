From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Nov 2013 13:23:48 +0100
Subject: [PATCH 02/31] ARM: tegra: document reset properties in DT bindings
In-Reply-To: <1384548866-13141-3-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-3-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131129122348.GO22771@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 01:53:57PM -0700, Stephen Warren wrote:
[...]
> diff --git a/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
[...]
> +  - resets : Must contain an entry for each entry in reset-names.
> +    See ../reset/reset.txt for details.
> +  - reset-names : Must include the following entries:
> +    - dc

For consistency with this, the clock-names entry for the first clock in
this node should then be "dc" as well.

> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
[...]
> -  - spdif_in
> +  - spdif

Why is this renamed?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131129/81266823/attachment.sig>
