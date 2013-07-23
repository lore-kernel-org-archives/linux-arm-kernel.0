From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 23 Jul 2013 10:36:11 -0300
Subject: [PATCH] ARM: dts: mxs: Add spi alias
In-Reply-To: <20130723133800.GA17327@S2101-09.ap.freescale.net>
References: <1374526049-29649-1-git-send-email-festevam@gmail.com>
 <20130723133800.GA17327@S2101-09.ap.freescale.net>
Message-ID: <51EE86CB.3010901@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2013 10:38 AM, Shawn Guo wrote:
   		gpio2 = &gpio2;
>> @@ -22,13 +24,13 @@
>>   		gpio4 = &gpio4;
>>   		saif0 = &saif0;
>>   		saif1 = &saif1;
>> +		spi0 = &ssp1;
>> +		spi1 = &ssp2;
>
> So this should be put after serial, right?

Yes, please check v2, which has this fixed.

Thanks,

Fabio Estevam
