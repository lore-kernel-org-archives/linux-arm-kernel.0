From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 1 Feb 2016 22:54:16 +0800
Subject: [PATCH 04/14] clk: sunxi: add ahb1 clock for A83T
In-Reply-To: <20160201144923.GA29286@rob-hp-laptop>
References: <1454203266-4450-1-git-send-email-vishnupatekar0510@gmail.com>
 <1454203266-4450-5-git-send-email-vishnupatekar0510@gmail.com>
 <20160201144923.GA29286@rob-hp-laptop>
Message-ID: <CAGb2v65zMGEagqML+2Y27M1hbdEWpMj96i0Dr5Ak67jnTcwhyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 1, 2016 at 10:49 PM, Rob Herring <robh@kernel.org> wrote:
> On Sun, Jan 31, 2016 at 09:20:56AM +0800, Vishnu Patekar wrote:
>> AHB1 on A83T is similar to ahb1 on A31, except parents are different.
>> clock index 0b1x is PLL6.
>>
>> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
>
> Acked-by: Rob Herring <robh@kernel.org>
>
>>  drivers/clk/sunxi/clk-sunxi.c                     | 75 +++++++++++++++++++++++
>>  2 files changed, 76 insertions(+)

Acked-by: Chen-Yu Tsai <wens@csie.org>
