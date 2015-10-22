From: jenskuske@gmail.com (Jens Kuske)
Date: Thu, 22 Oct 2015 09:32:53 +0200
Subject: [linux-sunxi] [PATCH 2/6] clk: sunxi: Add H3 clocks support
In-Reply-To: <CAGRGNgWyNEOMVxeDFTAp_wJoaXL471spFjBTn+2s7YuKeJf71g@mail.gmail.com>
References: <1445444007-4260-1-git-send-email-jenskuske@gmail.com>
 <1445444007-4260-3-git-send-email-jenskuske@gmail.com>
 <CAGRGNgWyNEOMVxeDFTAp_wJoaXL471spFjBTn+2s7YuKeJf71g@mail.gmail.com>
Message-ID: <56289125.2060408@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 22/10/15 02:15, Julian Calaby wrote:
> 
> This hunk should be in patch 1:

Indeed, Thanks.

Jens

> 
>> @@ -1000,9 +1005,8 @@ static void __init sunxi_divs_clk_setup(struct device_node *node,
>>
>>                 for (i = 0; i < SUNXI_DIVS_BASE_NAME_MAX_LEN - 1 &&
>>                                                 clk_name[i] != '_' &&
>> -                                               clk_name[i] != '\0'; i++) {
>> +                                               clk_name[i] != '\0'; i++)
>>                         base_name[i] = clk_name[i];
>> -               }
>>
>>                 base_name[i] = '\0';
>>                 factors.name = base_name;
> 
> Thanks,
> 
