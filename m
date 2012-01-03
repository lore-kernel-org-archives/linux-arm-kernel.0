From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 3 Jan 2012 14:42:19 -0800
Subject: [PATCH] Input: tegra-kbc - add device tree support
In-Reply-To: <1325629702-10307-1-git-send-email-olof@lixom.net>
References: <1325484557-27695-1-git-send-email-olof@lixom.net>
 <1325629702-10307-1-git-send-email-olof@lixom.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17761F1203@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Tuesday, January 03, 2012 3:28 PM:
> This includes an optional "linux,fn-keymap" binding that is not yet implemented,
> that will be used to specify the Fn-key modifier layout if needed.

> diff --git a/Documentation/devicetree/bindings/input/tegra-kbc.txt
...
> +Required properties:
> +- compatible: "nvidia,tegra20-kbc", "matrix-keyboard-controller"

I think "matrix-keyboard-controller" should be dropped now?

Otherwise,

Acked-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
