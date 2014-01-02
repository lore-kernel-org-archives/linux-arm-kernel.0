From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 2 Jan 2014 09:50:35 -0500
Subject: [PATCH v2] ARM: Kirkwood: Add support for Excito Bubba B3
In-Reply-To: <1388427467-32488-1-git-send-email-andrew@lunn.ch>
References: <1388427467-32488-1-git-send-email-andrew@lunn.ch>
Message-ID: <20140102145035.GG19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 30, 2013 at 07:17:46PM +0100, Andrew Lunn wrote:
> The Excito Bubba B3 is a home server, single drive NAS box, Wifi
> access point, etc.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v2:
> s/driver/drive
> Sort ocp DT entries
> Add comment about Serial port RX/TX test points
> Replace linux specific DT led properties with generic equivelent.
> ---
>  arch/arm/boot/dts/Makefile        |    3 +-
>  arch/arm/boot/dts/kirkwood-b3.dts |  204 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 206 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/kirkwood-b3.dts

Applied to mvebu/dt

thx,

Jason.
