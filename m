From: horms@verge.net.au (Simon Horman)
Date: Wed, 10 Feb 2016 18:55:59 +0100
Subject: [PATCH v3 7/8] ARM: dts: r8a7790: add iommus to dmac0 and dmac1
In-Reply-To: <1455065878-11906-8-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1455065878-11906-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1455065878-11906-8-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <20160210175559.GD17671@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Niklas,

I am deferring accepting this and the similar patch for the r8a7791 pending
acceptance of the driver changes earlier in this series. Please let me know
if you prefer a different course of action.

I notice that the devel branch of there renesas tree there are
dmac nodes for the r8a7793, r8a7794 and r8a7795. Is this change,
also suitable for those SoCs? If so, do you plan to update them?
If not I'll add it to my todo list.
