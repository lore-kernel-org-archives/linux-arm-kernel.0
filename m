From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sun, 16 Oct 2011 10:39:29 +0300
Subject: [PATCH v2] mach-ep93xx: break out GPIO driver specifics
In-Reply-To: <20111015204129.GZ21648@n2100.arm.linux.org.uk>
References: <1316508132-20020-1-git-send-email-linus.walleij@stericsson.com>
	<20111015181808.GA3128@mwesterb-mobl.ger.corp.intel.com>
	<20111015204129.GZ21648@n2100.arm.linux.org.uk>
Message-ID: <20111016073928.GB2642@mwesterb-mobl.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 15, 2011 at 09:41:30PM +0100, Russell King - ARM Linux wrote:
> 
> Hmm.  It shouldn't have been deleted - Linus' patch leaves the file
> empty rather than deleting it.
> 
> However, as I had to use GNU patch to apply Linus' patch (as git apply
> wouldn't because of fuzz), it doesn't understand that, so it removed it.
> This is where having an /* empty */ comment avoids that kind of thing,
> just like I've done for all the other mach/gpio.h which became empty.

Ok, thanks for the explanation.

I'll send a patch which fixes this later today.
