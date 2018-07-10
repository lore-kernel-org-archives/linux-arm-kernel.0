From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Jul 2018 22:02:39 +0800
Subject: [PATCH v5 03/22] dt-bindings: sram: sunxi: Introduce new A10
 binding for system-control
In-Reply-To: <20180710080114.31469-4-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
 <20180710080114.31469-4-paul.kocialkowski@bootlin.com>
Message-ID: <CAGb2v661JHS7r=6LE1em18owSUwk8VXbAGCAVez7=2u5P2R4Jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 4:00 PM, Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
> Following-up on the introduction of a new binding for the A64, this
> introduces a system-control binding for the A10 as a replacement of
> the sram-controller binding.
>
> This change is motivated by consistency with the Allwinner literature,
> that mentions system control over SRAM controller. Moreover, the system
> control block is sometimes used for more than SRAM (e.g. for muxing
> related to the ethernet PHY).
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
