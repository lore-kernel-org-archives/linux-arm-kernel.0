From: lukasz.goralczyk@gmail.com (=?UTF-8?Q?=C5=81ukasz_G=C3=B3ralczyk?=)
Date: Fri, 28 May 2010 12:59:27 +0200
Subject: Problem with at91_mci and AT91RM9200
In-Reply-To: <52497.72.68.115.39.1274971187.squirrel@webmail.hostgator.com>
References: <1274966669.2465.105.camel@arcturus>
	<52497.72.68.115.39.1274971187.squirrel@webmail.hostgator.com>
Message-ID: <1275044367.2401.3.camel@arcturus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dnia 2010-05-27, czw o godzinie 09:39 -0500, zql at glomationinc.com pisze:
[cut]
> > I compiled newest kernel (2.6.33.4 and 2.6.32 with at91 patches
> > http://www.at91.com/linux4sam/bin/view/Linux4SAM/LinuxKernel#AT91_Linux_kernel_sources_summar
> > )
> > which boots but fails to detect SD Card (Sandisk microSD 2 GB through SD
> > adapter). A the end there's a debugging output (stripped, full:
[cut]
> The MMC/SD card driver is broken for Atmel 9G20 as well since 2.6.30.  It
> no longer detect cards that used to work on 2.6.27.

In my case 2.6.27 doesn't work either - symptoms are similar as for
2.6.33.

Lukasz.
