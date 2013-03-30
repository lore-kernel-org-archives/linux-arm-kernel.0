From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 30 Mar 2013 18:12:12 -0400
Subject: [PATCH v3] ARM: dove: add more hardware description in the DT
In-Reply-To: <20130326080719.2d4d6450@armhf>
References: <20130326080719.2d4d6450@armhf>
Message-ID: <20130330221212.GC13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 08:07:19AM +0100, Jean-Francois Moine wrote:
> The 88AP510 chip (Marvell Dove) contains a LCD controller, a display
> controller and two audio controllers.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
> v3 from Sebastian Hesselbarth remarks
>    - dcon register block ends at 0xc4
> v2 from Sebastian Hesselbarth remarks
>    - better names for the devices
>    - fix bad i2s interrupt controller
>    - 2 irq's by audio controller
>    - display controller added
> ---
>  arch/arm/boot/dts/dove.dtsi |   38 +++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)

Applied to mvebu/dt

thx,

Jason.
