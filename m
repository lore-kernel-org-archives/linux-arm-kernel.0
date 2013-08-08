From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 08 Aug 2013 11:35:59 -0600
Subject: [PATCH v2 2/3] ARM: dt: t114 dalmore: add dt entry for nct1008
In-Reply-To: <1375944991-29182-3-git-send-email-wni@nvidia.com>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <1375944991-29182-3-git-send-email-wni@nvidia.com>
Message-ID: <5203D6FF.1060000@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2013 12:56 AM, Wei Ni wrote:
> Enable thermal sensor nct1008 for t114 dalmore.

It'd be best to remove this patch from the series; send one series to
the LM90 maintainer with just the driver and DT binding changes, and
another series to the Tegra maintainer with the *.dts changes. You can
tell me not to apply the *.dts changes until the driver/binding changes
are accepted (or just wait until they are before sending the patch).
