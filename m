From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Fri, 25 Jul 2014 12:04:59 +0200
Subject: [PATCH v2 00/11] ARM: dts: zynq: Prepare Parallella
In-Reply-To: <dc23839c-7a69-4674-9d92-80a1d68e9b23@BY2FFO11FD003.protection.gbl>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <dc23839c-7a69-4674-9d92-80a1d68e9b23@BY2FFO11FD003.protection.gbl>
Message-ID: <53D22BCB.9060500@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Punnaiah,

Am 25.07.2014 05:49, schrieb Punnaiah Choudary Kalluri:
>> Punnaiah Choudary Kalluri had recently proposed to extend the Chipidea
>> USB driver for Zynq; it kept complaining about the PHY though, and I
>> haven't spotted a revised version based on the generic driver yet.
>> https://patchwork.kernel.org/patch/4434681/
> 
> The plan is, go with generic chip idea driver which is currently under review. 
> http://www.spinics.net/lists/linux-usb/msg109576.html
> 
> So, please wait some more time for extending the Chip idea driver support
>  to zynq.

Thanks, I did understand that from the Patchwork link. I was however
wondering whether you already have some work branch based on Antoine
T?nart's series that you could share?

When we get HDMI working, a USB keyboard will come very handy. ;)

Otherwise, could you please take a look at my branch and let me know
whether I'm doing something fundamentally wrong in wiring your old
driver up in my DT? I did not see any .dts example doing so.

Cheers,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
