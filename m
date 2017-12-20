From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Dec 2017 15:45:04 -0600
Subject: [PATCH v2] ARM: dts: sunxi: Add sid for a83t
In-Reply-To: <20171219210523.10428-1-kevans91@ksu.edu>
References: <20171219210523.10428-1-kevans91@ksu.edu>
Message-ID: <20171220214504.5n6w5yijwu3iek5l@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 03:05:23PM -0600, kevans91 at ksu.edu wrote:
> Allwinner a83t has a 1 KB sid block with efuse for security rootkey and
> thermal calibration data, add node to describe it.
> 
> a83t-sid is not currently supported by nvmem/sunxi-sid, but it is
> supported in an external driver for FreeBSD.
> 
> Signed-off-by: Kyle Evans <kevans91@ksu.edu>
> ---
> 
> Changes in v2:
>  - remove bogus "From:" line in commit text; no functional change
> 
>  Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt | 1 +
>  arch/arm/boot/dts/sun8i-a83t.dtsi                               | 5 +++++
>  2 files changed, 6 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
