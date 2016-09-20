From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 20 Sep 2016 18:41:53 +0100
Subject: [PATCH 3/4] ARM: tegra: nyan-big: Include compatible revisions
 for proper detection
In-Reply-To: <20160828173246.32621-3-contact@paulk.fr>
References: <20160828173246.32621-1-contact@paulk.fr>
 <20160828173246.32621-3-contact@paulk.fr>
Message-ID: <a9485a88-55a5-9dd1-1a1b-a6c0a78ff476@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 28/08/16 18:32, Paul Kocialkowski wrote:
> Depthcharge (the payload used with cros devices) will attempt to detect
> boards using their revision. This includes all the known revisions for
> the nyan-big board so that the dtb can be selected preferably.

May be I am missing something here, but for the mainline there is only
one dtb available and so why is this needed for the mainline?

I understand for the downstream kernels that the chromebooks ship with
they may include multiple dtbs, but for the mainline we only have one.

Cheers
Jon

-- 
nvpublic
