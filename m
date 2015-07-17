From: olof@lixom.net (Olof Johansson)
Date: Fri, 17 Jul 2015 10:38:53 -0700
Subject: [PATCH 2/3] arm64: defconfig: enable ARCH_ROCKCHIP
In-Reply-To: <2272837.iN99Vuxs2j@diego>
References: <2820374.NgluYWXZkW@diego>
 <2272837.iN99Vuxs2j@diego>
Message-ID: <20150717173853.GN21691@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 12:34:23AM +0200, Heiko St?bner wrote:
> Enable building Rockchip support in the defconfig.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)

APplied, but based on earlier email with Will, we might need to deal with this
conflicting with them enabling feature options. Should be manageable.


-Olof
