From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 25 Jul 2013 16:09:03 -0400
Subject: [PATCH 2/2] ARM: Kirkwood: update defconfig for used i2c
 devices, EXT4 FS, r8169
In-Reply-To: <1374079910-24345-3-git-send-email-andrew@lunn.ch>
References: <1374079910-24345-1-git-send-email-andrew@lunn.ch>
 <1374079910-24345-3-git-send-email-andrew@lunn.ch>
Message-ID: <20130725200903.GW23879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 06:51:50PM +0200, Andrew Lunn wrote:
> Various kirkwood boards make use of i2c devices. Ensure the defconfig
> builds them. Also, EXT4 FS is also common on NAS boxes, so include it
> as well. And lastly, NSA310 has a RealTek 8169 onboard.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/configs/kirkwood_defconfig |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Applied to mvebu/defconfig

thx,

Jason.
