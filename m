From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 1 Feb 2016 23:11:23 +0800
Subject: [PATCH 02/14] clk: sunxi: Add apb0 gates for A83T
In-Reply-To: <20160201150218.GA4290@rob-hp-laptop>
References: <1454203266-4450-1-git-send-email-vishnupatekar0510@gmail.com>
 <1454203266-4450-3-git-send-email-vishnupatekar0510@gmail.com>
 <20160201150218.GA4290@rob-hp-laptop>
Message-ID: <CAGb2v64VjfDVDMSO_ov0mJfXTbgB7ffehGu4N8tCTs8Kt00fRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 1, 2016 at 11:02 PM, Rob Herring <robh@kernel.org> wrote:
> On Sun, Jan 31, 2016 at 09:20:54AM +0800, Vishnu Patekar wrote:
>> APB0 is part of PRCM, and is compatible with earlier SOCs.
>> apb0 gates controls R_PIO, R_UART, R_RSB, etc clocks.
>> This patch adds support for APB0 gates for A83T.
>>
>> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/clock/sunxi.txt | 1 +
>>  drivers/clk/sunxi/clk-simple-gates.c              | 2 ++
>>  2 files changed, 3 insertions(+)
>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
