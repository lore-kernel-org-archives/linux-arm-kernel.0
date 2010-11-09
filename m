From: alandpearson@gmail.com (Alan Pearson)
Date: Tue, 9 Nov 2010 16:52:31 +0000
Subject: w1-gpio oops
In-Reply-To: <87lj524hrt.fsf@lechat.rtp-net.org>
References: <E0675DE1-DC0C-40AE-947B-D4BD96C18993@gmail.com>
	<86F2C9C455334D048B154F93A214DF12@wipblrx0099946>
	<BFBAEA51-E7E6-4960-848D-5904BB209102@gmail.com>
	<AAD30849854E4B829FAF535B604B1B34@wipblrx0099946>
	<8D0E58DD-1923-4321-A0B3-9FBD2DDA3529@gmail.com>
	<87lj524hrt.fsf@lechat.rtp-net.org>
Message-ID: <F67FCEAB-7AD7-4920-969C-124C4C172DBC@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>>> P. So u might need to define those
>>> in your board file.
>>> 
>> 
>> OK, I've modified my board file like so (guruplug-setup.c) :
>> 
>> 
>> static struct w1_gpio_platform_data guru_gpio_platform_data = {
>>        .pin                    = MPP38_GPIO,
> 
> It's 38 not MPP38_GPIO. MPP38_GPIO is for the guruplug_mpp_config[]
> stuff (looks at how the leds are configured for instance)
> 
> 
> Arnaud
> 
> 


Guys, thanks. I've now got the module loading and utilising the GPIO pin.
I know it is, because I cannot now grab the GPIO pin for normal GPIO as the w1_gpio driver has claimed ownership.

I can't get it to see my device yet, but I'll get that figured out soon I hope.

Many thanks for all your help, it is really appreciated here.

Alan
