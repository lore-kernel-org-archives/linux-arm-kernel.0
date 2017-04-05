From: ray.jui@broadcom.com (Ray Jui)
Date: Wed, 5 Apr 2017 11:27:36 -0700
Subject: drivers/clk/bcm/clk-iproc-pll.c:280]: (style) Redundant condition
In-Reply-To: <HE1PR0801MB186548205AD0A49B09F6A3149C330@HE1PR0801MB1865.eurprd08.prod.outlook.com>
References: <HE1PR0801MB186548205AD0A49B09F6A3149C330@HE1PR0801MB1865.eurprd08.prod.outlook.com>
Message-ID: <a7ed0f26-fbe6-c5d3-62d3-e940a7fec5ac@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Thanks for reporting. I'll send out a patch to address this.

Ray

On 3/27/2017 3:47 AM, David Binderman wrote:
> Hello there,
> 
> 
> linux-4.11-rc4/drivers/clk/bcm/clk-iproc-pll.c:280]: (style) Redundant condition: If 'rate >= 2200000000', the comparison 'rate' is always true.
> 
> Source code is
> 
>     } else if (rate >= VCO_HIGH && rate && rate < VCO_HIGH_HIGH) {
> 
> Suggest new code
> 
>     } else if (rate >= VCO_HIGH  && rate < VCO_HIGH_HIGH) {
> 
> Regards
> 
> David Binderman
> 
