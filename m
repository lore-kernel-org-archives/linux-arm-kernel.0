From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 30 Mar 2013 20:30:34 -0400
Subject: [PATCH v4] ARM: dove: add more hardware description in the DT
In-Reply-To: <20130329104046.3870e77f@armhf>
References: <20130329104046.3870e77f@armhf>
Message-ID: <20130331003034.GG13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 29, 2013 at 10:40:46AM +0100, Jean-Francois Moine wrote:
> The 88AP510 chip (Marvell Dove) contains a LCD controller, a display
> controller and two audio controllers.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
> v4 from Andrew Lunn 
>    - i2s register blocks reduced to 0x2210 bytes
> v3 from Sebastian Hesselbarth
>    - dcon register block ends at 0xc4
> v2 from Sebastian Hesselbarth
>    - better names for the devices
>    - fix bad i2s interrupt controller
>    - 2 irq's by audio controller
>    - display controller added
> ---
>  arch/arm/boot/dts/dove.dtsi |   38 +++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)

replaced previous version with this one in mvebu/dt

thx,

Jason.
