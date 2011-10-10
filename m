From: fercerpav@gmail.com (Paul Fertser)
Date: Mon, 10 Oct 2011 14:01:32 +0400
Subject: [RFC][PATCH] plat-mxc: iomux-v3.h: implicitly enable
	pull-up/down when that's desired
In-Reply-To: <20114.49362.842057.846334@ipc1.ka-ro>
References: <201110100758.p9A7wCYT011235@home.pavel.comp>
	<20111010081407.GA32718@sapphire.tkos.co.il>
	<20114.49362.842057.846334@ipc1.ka-ro>
Message-ID: <20111010100132.GP9395@home.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2011 at 11:54:26AM +0200, Lothar Wa?mann wrote:
> Baruch Siach writes:
> > IMO, this patch should include the removal of the now redundant PAD_CTL_PKE 
> > from arch/arm/plat-mxc/include/mach/iomux-mx25.h, and other v3 iomux headers.
> > 
> Why should PAD_CTL_PKE be redundant? You still need it to configure a
> pin for the 'Keeper' functionality.
> Even if there is no default pin configuration that uses this, it
> should be possible to enable it when desired.

He meant not removing the definition itself but removing its usage
whereever it becomes redudant if my patch is accepted. I can do that
with a follow-up patch if desired.

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav at gmail.com
