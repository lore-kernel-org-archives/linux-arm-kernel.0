From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 5 Jun 2013 09:27:34 +0300
Subject: [PATCH] clk: tegra114: Fix msenc clock register
In-Reply-To: <51AE0F1B.20602@wwwdotorg.org>
References: <1370345143-4885-1-git-send-email-mperttunen@nvidia.com>
 <51AE0F1B.20602@wwwdotorg.org>
Message-ID: <op.wx6z781wpdlnwf@mperttunen-lnx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ah, sorry about that. I did actually use get_maintainer.pl, and it listed  
you
on the first line :) It looks like only drivers/clk/clk-* is assigned to  
Mike
according to MAINTAINERS, and the tegra/ subdirectory isn't.

On Tue, 04 Jun 2013 19:00:27 +0300, Stephen Warren <swarren@wwwdotorg.org>  
wrote:

> On 06/04/2013 05:25 AM, Mikko Perttunen wrote:
>> The msenc clock's register was set to the usb3 clock's register.
>
> drivers/clk changes should be sent to Mike Turquette (CC'd here). See
> the output of ./scripts/get_maintainer.pl and/or the MAINTAINERS file.
>
> Hopefully he can pick this up from the ARM mailing list - if not, I'm
> sure he'll let you know to resend it.
