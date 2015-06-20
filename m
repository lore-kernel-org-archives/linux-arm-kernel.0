From: tremyfr@gmail.com (Philippe Reynes)
Date: Sat, 20 Jun 2015 18:48:17 +0200
Subject: [PATCH v2 2/6] imx35: define two clocks for rtc
In-Reply-To: <CAOMZO5DOC2WXAVLxv_srHAZVAtnhTaP1yqYL9iQvJivKHRj1jA@mail.gmail.com>
References: <1434809732-8996-1-git-send-email-tremyfr@gmail.com>
 <1434809732-8996-3-git-send-email-tremyfr@gmail.com>
 <CAOMZO5DOC2WXAVLxv_srHAZVAtnhTaP1yqYL9iQvJivKHRj1jA@mail.gmail.com>
Message-ID: <55859951.5090308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On 20/06/15 16:43, Fabio Estevam wrote:
> On Sat, Jun 20, 2015 at 11:15 AM, Philippe Reynes<tremyfr@gmail.com>  wrote:
>
>> @@ -240,6 +241,9 @@ int __init mx35_clocks_init(void)
>>          clk_register_clkdev(clk[ipg], "ipg", "imx21-uart.1");
>>          clk_register_clkdev(clk[uart3_gate], "per", "imx21-uart.2");
>>          clk_register_clkdev(clk[ipg], "ipg", "imx21-uart.2");
>> +       /* i.mx35 has the i.mx21 type uart */
>
> I think you meant rtc, not uart :-)

Yes, of course, sorry for this silly mistake.
I fix it in a V3.

Thanks a lot,
Philippe
