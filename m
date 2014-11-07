From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 6 Nov 2014 22:32:01 -0500
Subject: [PATCH 3/3] mvebu: defconfig: Enable the mv88E6171 switch driver
In-Reply-To: <1415214121-29286-4-git-send-email-andrew@lunn.ch>
References: <1415214121-29286-1-git-send-email-andrew@lunn.ch>
 <1415214121-29286-4-git-send-email-andrew@lunn.ch>
Message-ID: <20141107033201.GF3698@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 05, 2014 at 08:02:01PM +0100, Andrew Lunn wrote:
> This switch is used by the 370-rd. Enable it and support for
> fixed-link phy configuration.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/configs/mvebu_v7_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Applied to mvebu/defconfig

thx,

Jason.
