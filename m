From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 31 Jan 2017 12:08:48 +0800
Subject: [PATCH v2 06/25] ARM: dtsi: axp209: add AXP209 ADC subnode
In-Reply-To: <20170127085458.18270-7-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-7-quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v66pKZQb1c84hu+2kxjPvAhmAK6z+TqPWT3ag=CyELQkiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 4:54 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> X-Powers AXP209 PMIC has multiple ADCs, each one exposing data from the
> different power supplies connected to the PMIC.
>
> This adds the ADC subnode for AXP20X PMIC.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Given the device node no longer exports anything, we might
as well drop it from the device tree.
