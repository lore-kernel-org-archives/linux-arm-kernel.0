From: alandpearson@gmail.com (Alan Pearson)
Date: Tue, 9 Nov 2010 14:56:33 +0000
Subject: w1-gpio oops
In-Reply-To: <AAD30849854E4B829FAF535B604B1B34@wipblrx0099946>
References: <E0675DE1-DC0C-40AE-947B-D4BD96C18993@gmail.com>
	<86F2C9C455334D048B154F93A214DF12@wipblrx0099946>
	<BFBAEA51-E7E6-4960-848D-5904BB209102@gmail.com>
	<AAD30849854E4B829FAF535B604B1B34@wipblrx0099946>
Message-ID: <41F19AF6-B2CE-4BE1-83D8-C607CE5AD3F1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> 
> 
> <CHOP>
> 
> Ok, I had understood the platform data was being set in the w1_gpio_custom module by the loadable options.
> Is this not the case, or does it also need defined in the board file, which I presume is guruplug_setup.c ?
> It's currently not defined there. But as I said I expected the other module to do this, am I wrong ?
> 
> 
> Looking at the function w1_gpio_probe, it doesnot seem to be using module params. So u might need to define those
> in your board file.
> 

But the w1_gpio_custom module does. Anyhow, I'm trying it out in the board file now.
I'll post back shortly.

Tnx
Alan
