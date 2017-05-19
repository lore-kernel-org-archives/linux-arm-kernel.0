From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 19 May 2017 10:28:05 +0800
Subject: [linux-sunxi] [PATCH v6 3/9] arm64: allwinner: a64: add NMI
 (R_INTC) controller on A64
In-Reply-To: <20170518071653.36561-4-icenowy@aosc.io>
References: <20170518071653.36561-1-icenowy@aosc.io>
 <20170518071653.36561-4-icenowy@aosc.io>
Message-ID: <CAGb2v65n9-3L3crs40ZE3UKh58V7piSqU7iix2ynoqY-W11mwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 3:16 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Allwinner A64 SoC features a R_INTC controller, which controls the NMI
> line, and this interrupt line is usually connected to the AXP PMIC.
>
> Add support for it.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
