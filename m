From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 21 Feb 2017 12:47:23 +0800
Subject: [PATCH v3 15/18] ARM: dtsi: axp209: add battery power supply
 subnode
In-Reply-To: <20170214094112.27426-16-quentin.schulz@free-electrons.com>
References: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
 <20170214094112.27426-16-quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v675ySdU=Ht6h5zyDOWFU3xZU32iDVOv5vj4AFDH+GQqcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2017 at 5:41 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The X-Powers AXP209 PMIC exposes battery supply various data such as
> the battery status (charging, discharging, full, dead), current max
> limit, current current, battery capacity (in percentage), voltage max
> and min limits, current voltage, and battery capacity (in Ah).
>
> This adds the battery power supply subnode for AXP20X PMIC.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
