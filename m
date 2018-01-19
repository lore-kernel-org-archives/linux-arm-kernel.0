From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 19 Jan 2018 10:34:38 +0530
Subject: [PATCH v5 21/44] clk: davinci: New driver for TI DA8XX USB PHY
 clocks
In-Reply-To: <8821ac95-ee3f-b53b-9a8a-598b69d1b35e@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-22-git-send-email-david@lechnology.com>
 <493e4809-6b77-7772-70c7-ad0fa04e9033@ti.com>
 <8821ac95-ee3f-b53b-9a8a-598b69d1b35e@lechnology.com>
Message-ID: <486d664f-1d55-0abd-27e2-cc9d7de112fa@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 January 2018 12:19 AM, David Lechner wrote:
>>
> 
> or to avoid defining a new macro?
> 
> 
>> ????regmap_write_bits(clk->regmap, CFGCHIP(2),
>> ????????????? CFGCHIP2_USB1PHYCLKMUX,
>> ????????????? index ? CFGCHIP2_USB1PHYCLKMUX : 0); 

Looks good as well!

Regards,
Sekhar
