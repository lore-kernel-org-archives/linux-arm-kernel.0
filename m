From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 29 Jun 2016 09:17:31 +0300
Subject: [RESEND PATCHv2 01/28] clk: ti: add ti_clk_get helper API
In-Reply-To: <20160628064749.GB28140@atomide.com>
References: <1465844702-12200-1-git-send-email-t-kristo@ti.com>
 <1465844702-12200-2-git-send-email-t-kristo@ti.com>
 <20160628064749.GB28140@atomide.com>
Message-ID: <577367FB.8070709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/06/16 09:47, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [160613 12:07]:
>> The API can be used to fetch directly DT clocks based on name. Using
>> this new API allows getting rid of most of the DT_CLK() entries under
>> drivers/clk/ti.
>
> The description here is a bit confusing.. Rather than calling it API
> how about say it's a helper function private to TI specific clock
> code? Otherwise people might think it will be something more widely
> available.

Yea, I can drop the API part from the desc, if we are going forward with 
this series.

-Tero
