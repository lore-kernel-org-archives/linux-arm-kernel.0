From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 26 May 2013 14:02:29 -0400
Subject: [PATCH v3 3/3] arm: kirkwood: Enable cpufreq and ondemand on
 kirkwood_defconfig
In-Reply-To: <1359281244-31455-4-git-send-email-andrew@lunn.ch>
References: <1359281244-31455-1-git-send-email-andrew@lunn.ch>
 <1359281244-31455-4-git-send-email-andrew@lunn.ch>
Message-ID: <20130526180229.GE31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 27, 2013 at 11:07:24AM +0100, Andrew Lunn wrote:
> Now that we have a cpufreq driver for kirkwood, enable it in
> kirkwood_defconfig and set the default governer to ondemand.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/configs/kirkwood_defconfig |    3 +++
>  1 file changed, 3 insertions(+)

Applied to mvebu/defconfig

thx,

Jason.
