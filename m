From: balbi@ti.com (Felipe Balbi)
Date: Fri, 8 Feb 2013 16:03:02 +0200
Subject: [PATCH v6 08/10] ARM: dt: Add references to tegra_car clocks
In-Reply-To: <1360330602-30472-9-git-send-email-pdeschrijver@nvidia.com>
References: <1360330602-30472-1-git-send-email-pdeschrijver@nvidia.com>
 <1360330602-30472-9-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20130208140301.GA23979@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Feb 08, 2013 at 03:36:40PM +0200, Peter De Schrijver wrote:
>  	tegra_car: clock {
> -		compatible = "nvidia,tegra114-car, nvidia,tegra30-car";
> +		compatible = "nvidia,tegra114-car";

trailing change or intentional ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130208/202974d2/attachment.sig>
