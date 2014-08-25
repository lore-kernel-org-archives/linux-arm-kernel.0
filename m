From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Aug 2014 11:40:33 -0600
Subject: [PATCH 0/8] Tegra124 EMC (external memory controller) support
In-Reply-To: <1405088313-20048-1-git-send-email-mperttunen@nvidia.com>
References: <1405088313-20048-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <53FB7511.9090205@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2014 08:18 AM, Mikko Perttunen wrote:
> Hi everyone,
>
> this series adds support for the EMC (external memory controller) clock
> in the Tegra124 system-on-chip. The series has been tested on Jetson TK1.
>
> The first two patches remove the old "emc_mux" and "emc" clocks from the
> clock tree and the device tree bindings. This is, of course, not backwards
> compatible, but as these clocks have never been useful for anything
> (apart from maybe reading the boot rate of the EMC clock). If this is still
> not acceptable, the second patch can be dropped.
...

Mikko, this series had some comments, especially on the DT binding 
(patch 5/8) and how the MC/EMC drivers interact. Is there an updated 
version of the series? Or, is the series replaced by Tomeu Vizoso's work?
