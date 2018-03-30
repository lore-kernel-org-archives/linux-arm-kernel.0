From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 30 Mar 2018 15:43:39 +0800
Subject: [linux-sunxi] [PATCH v2 09/10] ARM: sun8i: h3: fix ALL-H3-CC H3
 ver VDD-CPUX voltage
In-Reply-To: <20180206044905.30508-10-icenowy@aosc.io>
References: <20180206044905.30508-1-icenowy@aosc.io>
 <20180206044905.30508-10-icenowy@aosc.io>
Message-ID: <CAGb2v67w6n=bawNaxfJfRi2+RrSRu6GeQG8=Oxh0YADM8AKnmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 6, 2018 at 12:49 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> The VDD-CPUX voltage of ALL-H3-CC H3 ver should be 1.2V, not the 3.3V
> currently defined in the device tree.
>
> Fix the voltage in the device tree.
>
> Fixes: 6ca358645d4d ("ARM: dts: sun8i: h3: Add dts file for Libre Computer Board ALL-H3-CC H3 ver.")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
