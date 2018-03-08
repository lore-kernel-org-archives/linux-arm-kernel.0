From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 8 Mar 2018 14:45:45 +0100
Subject: [PATCH v4 2/7] soc/tegra: Add Tegra194 SoC configuration option
In-Reply-To: <20180220115812.24108-3-mperttunen@nvidia.com>
References: <20180220115812.24108-1-mperttunen@nvidia.com>
 <20180220115812.24108-3-mperttunen@nvidia.com>
Message-ID: <20180308134545.GF3529@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 01:58:07PM +0200, Mikko Perttunen wrote:
> Add the configuration option to enable support for the Tegra194
> system-on-chip, and enable it by default in the arm64 defconfig.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  arch/arm64/configs/defconfig |  1 +
>  drivers/soc/tegra/Kconfig    | 10 ++++++++++
>  2 files changed, 11 insertions(+)

defconfig changes should be in a separate patch because they need to go
into different branches in the ARM SoC tree. I've fixed that up, but
maybe something to keep in mind for next time.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180308/4f9401b0/attachment.sig>
