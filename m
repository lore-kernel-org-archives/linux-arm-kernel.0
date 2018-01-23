From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 23 Jan 2018 23:50:58 +0800
Subject: [PATCH v3 14/16] ARM: dtsi: axp81x: add battery power supply
 subnode
In-Reply-To: <9c045de8dcee9a71803978855762e272efdc41d3.1516012352.git-series.quentin.schulz@free-electrons.com>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
 <9c045de8dcee9a71803978855762e272efdc41d3.1516012352.git-series.quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v64UCOWccggsVyHSfngYYcMjSUUEP-7s5qkSRZie-hGBAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 15, 2018 at 6:33 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The X-Powers AXP81X PMIC exposes battery supply various data such as
> the battery status (charging, discharging, full, dead), current max
> limit, current current, battery capacity (in percentage), voltage max
> and min limits, current voltage, and battery capacity (in Ah).
>
> This adds the battery power supply subnode for AXP81X PMIC.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
