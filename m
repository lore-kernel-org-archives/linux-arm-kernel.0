From: gang.chen@asianux.com (Chen Gang)
Date: Thu, 22 Aug 2013 15:24:01 +0800
Subject: [PATCH] ARM: OMAP2: remove useless variable 'ret'
In-Reply-To: <20130822071702.GR7656@atomide.com>
References: <521479B4.8030604@asianux.com> <52147AC6.9040300@asianux.com>
 <20130822071702.GR7656@atomide.com>
Message-ID: <5215BC91.4080801@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2013 03:17 PM, Tony Lindgren wrote:
> * Chen Gang <gang.chen@asianux.com> [130821 01:39]:
>> Remove useless variable 'ret', the related warning:
>>
>>   arch/arm/mach-omap2/board-am3517crane.c:113:6: warning: unused variable ?ret? [-Wunused-variable]
> 
> Thanks applying into omap-for-v3.12/fixes-non-critical.
> 

Thank you too.


> Regards,
> 
> Tony 
>  
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> ---
>>  arch/arm/mach-omap2/board-am3517crane.c |    2 --
>>  1 files changed, 0 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
>> index fc53911..0d499a1 100644
>> --- a/arch/arm/mach-omap2/board-am3517crane.c
>> +++ b/arch/arm/mach-omap2/board-am3517crane.c
>> @@ -110,8 +110,6 @@ static void __init am3517_crane_i2c_init(void)
>>  
>>  static void __init am3517_crane_init(void)
>>  {
>> -	int ret;
>> -
>>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>>  	omap_serial_init();
>>  	omap_sdrc_init(NULL, NULL);
>> -- 
>> 1.7.7.6
> 
> 


-- 
Chen Gang
