From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Apr 2012 09:31:30 +0100
Subject: [PATCH/RFC v2] ARM: amba: Remove AMBA level regulator support
In-Reply-To: <20120406074942.GO7264@S2101-09.ap.freescale.net>
References: <1333306720-28344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120406074942.GO7264@S2101-09.ap.freescale.net>
Message-ID: <20120410083130.GK24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 06, 2012 at 03:49:45PM +0800, Shawn Guo wrote:
> I believe this patch fixes the amba probe failure that impacts any
> AMBA platform build with CONFIG_REGULATOR enabled.  Could you consider
> to send the fix for -rc soon?

No idea.  I don't have Mark's patch in the patch system.

> The patch "ARM: amba: adapt to regulator probe deferral change" from
> me could be ignored now.

But I do have yours in there.  And what do I do with your other patch
in there touching this same area as well?

Please, sort it out between you and once the patch system is right, let
me know.
