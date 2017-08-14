From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 14 Aug 2017 17:37:40 +0800
Subject: [linux-sunxi] [PATCH 1/4] dt-bindings: add binding for Allwinner
 A64 SRAM controller and SRAM C
In-Reply-To: <20170809085627.32687-2-icenowy@aosc.io>
References: <20170809085627.32687-1-icenowy@aosc.io>
 <20170809085627.32687-2-icenowy@aosc.io>
Message-ID: <CAGb2v66p1rjTONyPJ0yHCUOnR82HZtiuhXa5phrsNe+bKf9+tA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 9, 2017 at 4:56 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> The display engine on Allwinner A64 wants to claim the SRAM C section.
>
> Add a SRAM controller compatible for A64, and a SRAM section compatible
> for its SRAM C.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Looks good to me. Will wait for device tree maintainers to have a say.

ChenYu
