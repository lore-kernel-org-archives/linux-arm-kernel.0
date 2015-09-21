From: scottwood@freescale.com (Scott Wood)
Date: Mon, 21 Sep 2015 18:13:45 -0500
Subject: [PATCH 6/6] dts/ls1043a: add LS1043ARDB board support
In-Reply-To: <1442838158-2964-7-git-send-email-B48286@freescale.com>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
 <1442838158-2964-7-git-send-email-B48286@freescale.com>
Message-ID: <1442877225.19102.207.camel@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-09-21 at 20:22 +0800, Zhiqiang Hou wrote:

> +             cpld: board-control at 2,0 {
> +                     compatible = "fsl,ls1043ardb-cpld", "simple-bus";
> +                     reg = <0x2 0x0 0x0000100>;
> +             };

Again, why "simple-bus"?

-Scott
