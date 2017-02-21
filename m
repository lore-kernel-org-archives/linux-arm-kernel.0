From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 21 Feb 2017 12:47:45 +0800
Subject: [PATCH v3 16/18] ARM: dtsi: axp22x: add battery power supply
 subnode
In-Reply-To: <20170214094112.27426-17-quentin.schulz@free-electrons.com>
References: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
 <20170214094112.27426-17-quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v65zjrsHFNuGEQ5xqALTEYvGqFXO3g6TU9w1h02=etJr=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2017 at 5:41 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The X-Powers AXP22X PMIC exposes battery supply various data such as
> the battery status (charging, discharging, full, dead), current max
> limit, current current, battery capacity (in percentage), voltage max
> limit, current voltage, and battery capacity (in Ah).
>
> This adds the battery power supply subnode for AXP22X PMIC.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
