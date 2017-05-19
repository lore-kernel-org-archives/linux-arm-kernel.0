From: robert.richter@cavium.com (Robert Richter)
Date: Fri, 19 May 2017 13:32:37 +0200
Subject: [PATCH 1/2] acpica: iort: Update SMMU models for IORT rev. C
In-Reply-To: <0bb462748c0a08dbf1db103d2a96b80c71412817.1494585645.git.robin.murphy@arm.com>
References: <0bb462748c0a08dbf1db103d2a96b80c71412817.1494585645.git.robin.murphy@arm.com>
Message-ID: <20170519113237.GN658@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.05.17 11:41:41, Robin Murphy wrote:
> IORT revision C has been published with a number of new SMMU
> implementation identifiers; define them.
> 
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Robert Moore <robert.moore@intel.com>
> CC: Lv Zheng <lv.zheng@intel.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

As an additional note, could these both patches being marked stable?
If we are going to deploy fw with the new model number, older kernels
become unusable as the smmu is not detected any longer.

Thanks,

-Robert
