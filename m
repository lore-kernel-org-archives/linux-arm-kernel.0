From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Mon, 23 Apr 2012 17:49:11 +0300
Subject: [PATCH] staging: tidspbridge: fix build errors for
 OMAP2_L4_IO_ADDRESS
In-Reply-To: <20120423143917.GD24299@n2100.arm.linux.org.uk>
References: <1335191654-1217-1-git-send-email-felipe.contreras@gmail.com>
 <20120423143917.GD24299@n2100.arm.linux.org.uk>
Message-ID: <CAMP44s0GDu91B5v90NKnOOiz0-N7iGp-q8MX_uBWEWLp8dSAng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 5:39 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Apr 23, 2012 at 05:34:14PM +0300, Felipe Contreras wrote:
>> drivers/staging/tidspbridge/core/tiomap3430.c: In function 'bridge_brd_start':
>> drivers/staging/tidspbridge/core/tiomap3430.c:425: error: implicit declaration of function 'OMAP2_L4_IO_ADDRESS'
>> drivers/staging/tidspbridge/core/wdt.c: In function 'dsp_wdt_init':
>> drivers/staging/tidspbridge/core/wdt.c:56: error: implicit declaration of function 'OMAP2_L4_IO_ADDRESS'
>>
>> The proper fix will come later.
>
> Hmm. ?Given that this is staging stuff, which hasn't been making much
> progress out of staging, I'd suggest not doing the quick fix on it, but
> spending the time to implement the proper fix now and move the code
> closer to the point where it can move out of staging.

Omar is already on that.

> You might get a gold star from Greg for moving this forward...

In my experience gold stars from Greg mean nothing.

Cheers.

-- 
Felipe Contreras
