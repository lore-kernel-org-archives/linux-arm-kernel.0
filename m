From: dianders@chromium.org (Doug Anderson)
Date: Tue, 15 Jul 2014 17:02:40 -0700
Subject: [PATCH 5/6] ARM: dts: rockchip: add core rk3288 dtsi
In-Reply-To: <1868508.hOA6VOBqnH@diego>
References: <1471578.ILeMmG2DL6@diego>
	<1868508.hOA6VOBqnH@diego>
Message-ID: <CAD=FV=X7n1bPHUw7+734x0xui9L1HO1otjczZ+rmKgBX0UdGDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Tue, Jul 15, 2014 at 4:02 PM, Heiko St?bner <heiko@sntech.de> wrote:
> +       soc {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "simple-bus";
> +               ranges;

I haven't had time to do a full review, but I believe "soc" grouping
is not suggested.  See <http://patchwork.ozlabs.org/patch/323194/>

-Doug
