From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 22 Aug 2016 13:01:11 -0600
Subject: [PATCH v3 06/12] soc/tegra: Add Tegra186 support
In-Reply-To: <20160819173233.13260-7-thierry.reding@gmail.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <20160819173233.13260-7-thierry.reding@gmail.com>
Message-ID: <c2e3d375-d68c-86af-c64c-1130d87780b1@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2016 11:32 AM, Thierry Reding wrote:
> From: Joseph Lo <josephl@nvidia.com>
>
> The Tegra186 has a combination of Denver and Cortex-A57 CPU cores and
> GPUs with Pascal architecture on it. It features with ADSP with
> Cortex-A9 CPU for audio processing, hardware video encoder/decoder with
> multi-format support, ISP for image capture processing and BPMP for the
> power managements.

Acked-by: Stephen Warren <swarren@nvidia.com>
