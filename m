From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Sat, 12 Aug 2017 10:59:33 -0700
Subject: [PATCH 0/3] Add DSP DT nodes on Keystone 66AK2G platforms
In-Reply-To: <20170810235245.30316-1-s-anna@ti.com>
References: <20170810235245.30316-1-s-anna@ti.com>
Message-ID: <b4413170-ed35-cf6c-22e2-ce633b8b561c@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 8/10/17 4:52 PM, Suman Anna wrote:
> Hi Santosh,
> 
> The following series adds the DT nodes for the DSP device present
> on the Keystone2 66AK2G SoC and enables them on the currently
> supported platforms.
> 
> The DTS nodes for the other Keystone2 family of SoCs were posted
> previously [1] and already in your staging branches for 4.14.
> This series adds the equivalent patches for 66AK2G SoCs. K2G uses
> slightly different properties compared to other K2 SoCs. The
> binding update for K2G is in-flight [2] and already acked by Rob.
> So, I am not sure if you need to wait for that patch to show up
> on mainline to avoid checkpatch warnings on these patches due to
> the undocumented compatible on your tree.
> 
> Validation done on K2G EVM and K2G ICE boards using ramdisk boot.
> Supported features are the same as the other Keystone 2 platforms.
> Patches are based on your current -next branch [3], so should apply
> fine on your 4.14 keystone_dts branch.
> 
Applied !!
