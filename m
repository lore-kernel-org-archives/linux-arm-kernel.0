From: michael.williamson@criticallink.com (Michael Williamson)
Date: Mon, 19 Jul 2010 07:43:33 -0400
Subject: [PATCH] davinci: Add MityDSP-L138/MityARM-1808 SOM support
In-Reply-To: <1279324167.4526.85.camel@Joe-Laptop.home>
References: <E1OZlTF-0006NW-1I@wanda>
	<1279324167.4526.85.camel@Joe-Laptop.home>
Message-ID: <4C443A65.4010105@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/16/2010 7:49 PM, Joe Perches wrote:
> On Fri, 2010-07-16 at 10:00 -0400, Michael Williamson wrote:
>   
>> +static __init void mityomapl138_setup_lcd(void)
>> +{
>>     
> []
>   
>> +			pr_warning("mityomapl138_init: unknown LCD type : %s\n",
>> +				peripheral_config.LCDConfig.PanelName);
>>     
> I think you'd be better off actually using the actual
> function name rather than the caller name
>   

Absolutely.   Didn't catch those when shuffling around during cleanup /
etc. 
I will clean these up and resubmit. 

Thank you for the feedback.

[Message resent due to bad client configuration].

-Mike
