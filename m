From: elopez93@gmail.com (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Mon, 23 Dec 2013 13:23:47 -0300
Subject: [PATCH 1/4] clk: sunxi: Allwinner A20 output clock support
In-Reply-To: <52B8613B.9040503@elopez.com.ar>
References: <1387787827-11341-1-git-send-email-wens@csie.org>
 <1387787827-11341-2-git-send-email-wens@csie.org>
 <52B8613B.9040503@elopez.com.ar>
Message-ID: <52B86393.8020202@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again,

El 23/12/13 13:13, Emilio L?pez escribi?:
> Hi,
>
> El 23/12/13 05:37, Chen-Yu Tsai escribi?:
>> This patch adds support for the external clock outputs on the
>> Allwinner A20 SoC. The clock outputs are similar to "module 0"
>> type clocks, with different offsets and widths for clock factors.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> This patch looks good to me,
>
> Acked-by: Emilio L?pez <emilio@elopez.com.ar>
>
>> ---
>>   drivers/clk/sunxi/clk-sunxi.c | 57
>> +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 57 insertions(+)

Please add the new binding to the binding document; I just noticed it 
was missing. You can keep the Ack once you do so.

Cheers,

Emilio
