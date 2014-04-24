From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 24 Apr 2014 00:27:17 -0400
Subject: [PATCH] ARM: mvebu: Add a SOC bus device entry
In-Reply-To: <1393955507-26436-1-git-send-email-andrew@lunn.ch>
References: <1393955507-26436-1-git-send-email-andrew@lunn.ch>
Message-ID: <20140424042717.GR28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 06:51:47PM +0100, Andrew Lunn wrote:
> Add the SoC Family, device ID and revision to /sys/bus/soc.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/mach-mvebu/Kconfig        |  1 +
>  arch/arm/mach-mvebu/mvebu-soc-id.c | 28 ++++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)

Applied to mvebu/soc

Please make sure to run make with -q to catch newly introduced warnings.
I added 'return 0;' to the end of the function, and explicitly 'return
0;' for !is_id_valid.

thx,

Jason.
