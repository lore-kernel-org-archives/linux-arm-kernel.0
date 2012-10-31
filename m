From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Wed, 31 Oct 2012 02:22:44 -0500
Subject: [PATCH 1/2] ARM: OMAP2+: move mailbox.h out of plat-omap headers
In-Reply-To: <20121030210213.GA6098@kroah.com>
References: <1351530381-11459-1-git-send-email-omar.luna@linaro.org>
 <1351530381-11459-2-git-send-email-omar.luna@linaro.org>
 <20121029175228.GD11908@atomide.com>
 <CALLhW=4ukBuRSVcPm2A37PgBhv33yKqk2G=Dz2XTUyswXw=JMg@mail.gmail.com>
 <20121030162441.GF11908@atomide.com>
 <20121030210213.GA6098@kroah.com>
Message-ID: <CALLhW=6p06MPdfbD2S-PRs=w0zLNsEifsJ2xL0hjEZaFpbadDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On 30 October 2012 16:02, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>> OK.
>>
>> Greg, do these patches look OK to you to move to live under
>> drivers/mailbox?
>
> Um, I don't know, I wasn't paying attention here, sorry.

As part of plat-omap code cleanup, I was planning to move omap-mailbox
framework to a newly drivers/mailbox folder, right now this code is
specific to OMAP platforms, but with some clean up it could be the
base for a generic framework. And living under drivers/mailbox could
give it some exposure for interested developers to give feedback and
propose changes.

In the past there was a mailbox-like driver in mach-ux500, I was
hoping both could live under the same folder, however the platform
using it, was dropped a couple of kernel releases back and with it the
other similar mailbox implementation.

So, here it is the thread with the patches:
http://thread.gmane.org/gmane.linux.kernel/1384603, if you think it is
OK for them to be moved under drivers/mailbox, I just need to re-spin
them to move the mailbox header file to include/linux/mailbox instead
of include/linux/platform_data.

Cheers,

Omar
