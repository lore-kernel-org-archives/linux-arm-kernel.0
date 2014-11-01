From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 1 Nov 2014 19:42:20 -0400
Subject: [PATCH 4/4] ARM: config: Add DLINK DIR665 options to
 multi_v5_defconfig
In-Reply-To: <1414793613-11798-5-git-send-email-andrew@lunn.ch>
References: <1414793613-11798-1-git-send-email-andrew@lunn.ch>
 <1414793613-11798-5-git-send-email-andrew@lunn.ch>
Message-ID: <20141101234220.GN3698@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm-soc folks,

On Fri, Oct 31, 2014 at 11:13:33PM +0100, Andrew Lunn wrote:
> Enable building of the switch chip driver and the wireless driver
> needed by the DLINK DIR665
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Cc: arm at kernel.org
> ---
>  arch/arm/configs/multi_v5_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

I went ahead and picked this since I don't foresee too many conflicts
like there are with multi_v7_defconfig.  Please let me know if you would
prefer to take changes to this file directly.

thx,

Jason.
