From: olof@lixom.net (Olof Johansson)
Date: Thu, 31 May 2012 14:04:29 -0700
Subject: [GIT PULL] at91: platform data for atmel-mci (for 3.5)
In-Reply-To: <4FC722B7.10409@atmel.com>
References: <4FBE4FE7.3010005@atmel.com>
	<4FC722B7.10409@atmel.com>
Message-ID: <CAOesGMhq8uzei+Dn8=1iYrTiAOtuByjm58j9zgFyORVG5VZuNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,


On Thu, May 31, 2012 at 12:50 AM, Nicolas Ferre <nicolas.ferre@atmel.com>wrote:

> On 05/24/2012 05:12 PM, Nicolas Ferre :
> > Hi Arnd, hi Olof,
>
> Ping?
>
> (or maybe you will have a look at this after the merge window...)
>

So, I looked at this branch yesterday but I wasn't entirely happy with the
number of ifdefs it adds.

If the idea is to deprecate the old driver, wouldn't it make more sense to
just cut everyone over instead of having both sets of setup in the kernel?


-Olof
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120531/f867477f/attachment-0001.html>
