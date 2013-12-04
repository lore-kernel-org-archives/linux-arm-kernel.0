From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 4 Dec 2013 09:20:24 +0100
Subject: [PATCH V2 1/2] ARM: tegra: Add header file for pinctrl constants
In-Reply-To: <1386076567-14283-1-git-send-email-ldewangan@nvidia.com>
References: <1386076567-14283-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <20131204082023.GA19943@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 06:46:06PM +0530, Laxman Dewangan wrote:
> This new header file defines pincontrol constants for Tegra to
> use from Tegra's DTS file for pincontrol properties option.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
> Changes from V1:
> - Get rid of lots of macro and converge it to TEGRA_PIN_ENABLE/DISABLE.
> - Change macro name for PULL UP/DOWN/NONE.
> 
>  include/dt-bindings/pinctrl/pinctrl-tegra.h |   40 +++++++++++++++++++++++++++
>  1 files changed, 40 insertions(+), 0 deletions(-)
>  create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra.h

I like this a lot. One minor nit below.

> diff --git a/include/dt-bindings/pinctrl/pinctrl-tegra.h b/include/dt-bindings/pinctrl/pinctrl-tegra.h
> new file mode 100644
> index 0000000..e5f02f8
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/pinctrl-tegra.h
> @@ -0,0 +1,40 @@
> +/*
> + * This header provides constants for TEGRA pinctrl bindings.

"TEGRA" -> "Tegra"

Other than that:

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131204/83136ac2/attachment-0001.sig>
