From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 22 Oct 2009 19:59:54 +0100
Subject: [PATCH] s3c24xx-adc: resume convertions interrupted by going to
	suspend
In-Reply-To: <200910221410.28632.anarsoul@gmail.com>
References: <200910201719.41102.anarsoul@gmail.com>
	<200910221410.28632.anarsoul@gmail.com>
Message-ID: <20091022185954.GA8096@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 22, 2009 at 02:10:23PM +0300, Vasily Khoruzhick wrote:
> ?? ?????????????????? ???? 20 ?????????????? 2009 17:19:30 ?????????? Vasily Khoruzhick ??????????????:
> > Fix for a bug that shows when the s3c2410 TS driver requests
> > a conversion from the s3c-adc driver and the machine goes into suspend.
> > In this case the touchscreen stops working.
> 
> Does anyone on maillist interested in this bugfix? I got no response for 2 
> days... 

I've been in and out of bed feeling ill, I can't sit on this list
24x7 looking at bugfixes.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
