From: peter.chen@nxp.com (Peter Chen)
Date: Tue, 8 Nov 2016 03:44:37 +0000
Subject: [PATCH 3/3] clk: imx: clk-imx6ul: add clk support for imx6ull
In-Reply-To: <20161105090506.GH5597@dragon>
References: <1477969343-19887-1-git-send-email-peter.chen@nxp.com>
 <1477969343-19887-4-git-send-email-peter.chen@nxp.com>
 <20161105090506.GH5597@dragon>
Message-ID: <HE1PR04MB1450B9A947E90F1E17DABB118BA60@HE1PR04MB1450.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks, Shawn. All comments will be adopted in v2.

Peter

>> +"pll4_audio_div", "pll3_pfd2_508m", "pll5_video_div", "pll3_usb_otg",
>> +}; static const char *epdc_sels[] = { "epdc_podf", "ipp_di0",
>> +"ipp_di1", "ldb_di0", "ldb_di1", };
>> +
>
>The new line is not needed.  There is already one below.
>
>>
>>  static struct clk *clks[IMX6UL_CLK_END];  static struct
>> clk_onecell_data clk_data;
>
 
>> -#define IMX6UL_CLK_END			225
>> +/* For i.MX6ULL */
>> +#define IMX6UL_CLK_ESAI_PRED		225
>> +#define IMX6UL_CLK_ESAI_PODF		226
>> +#define IMX6UL_CLK_ESAI_EXTAL		227
>> +#define IMX6UL_CLK_ESAI_MEM		228
>> +#define IMX6UL_CLK_ESAI_IPG		229
>> +#define IMX6UL_CLK_DCP_CLK		230
>> +#define IMX6UL_CLK_EPDC_PRE_SEL		231
>> +#define IMX6UL_CLK_EPDC_SEL		232
>> +#define IMX6UL_CLK_EPDC_PODF		233
>> +#define IMX6UL_CLK_EPDC_ACLK		234
>> +#define IMX6UL_CLK_EPDC_PIX		235
>> +#define IMX6UL_CLK_ESAI_SEL		236
>
>Can we have these imx6ull only clocks named after IMX6ULL_xxx?
>
>Shawn
 
