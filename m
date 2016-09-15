From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Sep 2016 22:33:50 +0800
Subject: [PATCH v2 6/8] ARM: dts: sun9i: a80-optimus: Add AXP806 PMIC
 device node and regulators
In-Reply-To: <20160827075544.26316-7-wens@csie.org>
References: <20160827075544.26316-1-wens@csie.org>
 <20160827075544.26316-7-wens@csie.org>
Message-ID: <CAGb2v65cQR9F1=0_9mM6guKrMhOX7TqMqfHJU5hJxUXtBZiYaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Sat, Aug 27, 2016 at 3:55 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> The AXP806 PMIC is the secondary PMIC. It provides various supply
> voltages for the SoC and other peripherals. The PMIC's interrupt
> line is connected to NMI pin of the SoC.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

The driver patches have all been merged into the mfd tree. Could
you queue up the dts patches?

Thanks
ChenYu
