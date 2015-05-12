From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 May 2015 20:36:40 -0600
Subject: BCM2836 (Raspberry Pi 2) port
In-Reply-To: <4137213.WVJY1et48u@kongar>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
 <5539C5A4.5070409@wwwdotorg.org> <4137213.WVJY1et48u@kongar>
Message-ID: <55516738.306@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2015 10:14 AM, Alexander Stein wrote:
> On Thursday 23 April 2015, 22:25:08 wrote Stephen Warren:
>>> Hit any key to stop autoboot:  0 
>>> U-Boot> setenv fdt_high fffffff
> 
> Any specific reason to set fdt_high to fffffff?

Yes, it prevents U-Boot's annoying habit of moving the DTB from where it
was loaded to some other place. This was especially important in this
case since I was trying to find out exactly which piece of RAM being
over-written caused the issues I was seeing.
