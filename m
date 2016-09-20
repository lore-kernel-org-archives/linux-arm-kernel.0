From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 20 Sep 2016 18:42:53 +0100
Subject: [PATCH 4/4] ARM: tegra: nyan-blaze: Include compatible revisions
 for proper detection
In-Reply-To: <20160828173246.32621-4-contact@paulk.fr>
References: <20160828173246.32621-1-contact@paulk.fr>
 <20160828173246.32621-4-contact@paulk.fr>
Message-ID: <ddc216d3-5449-4250-8fd8-6f343d020403@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 28/08/16 18:32, Paul Kocialkowski wrote:
> Depthcharge (the payload used with cros devices) will attempt to detect
> boards using their revision. This includes all the known revisions for
> the nyan-blaze board so that the dtb can be selected preferably.

Again I am not sure what the benefit/need for this is.

Jon

-- 
nvpublic
