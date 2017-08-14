From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 14 Aug 2017 17:48:31 +0800
Subject: [linux-sunxi] [PATCH 4/4] drivers: soc: sunxi: add support for
 A64 and its SRAM C
In-Reply-To: <20170809085627.32687-5-icenowy@aosc.io>
References: <20170809085627.32687-1-icenowy@aosc.io>
 <20170809085627.32687-5-icenowy@aosc.io>
Message-ID: <CAGb2v66RnXDbL7OJfOAgeXPJSFZwzgfGbnB108vX-+OO_0xiWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 9, 2017 at 4:56 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Allwinner A64's display engine claims the SRAM C section to work.
>
> Add support for the A64 SRAM controller and the SRAM C section of it.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Looks good to me. Will apply all 4 once the dt bindings are acked.

ChenYu
