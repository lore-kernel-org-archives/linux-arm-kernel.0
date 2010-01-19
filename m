From: greg@kroah.com (Greg KH)
Date: Tue, 19 Jan 2010 07:54:50 -0800
Subject: [PATCH] staging/dream: add missing include files/fix compilation
In-Reply-To: <20100119054516.GB22153@elf.ucw.cz>
References: <20091225205917.GA25761@elf.ucw.cz>
	<20100115002419.GA25643@kroah.com>
	<20100119054516.GB22153@elf.ucw.cz>
Message-ID: <20100119155450.GA15505@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2010 at 06:45:17AM +0100, Pavel Machek wrote:
> On Thu 2010-01-14 16:24:19, Greg KH wrote:
> > On Fri, Dec 25, 2009 at 09:59:18PM +0100, Pavel Machek wrote:
> > > This adds missing include files, so it should now compile. ifdef
> > > guards were added to Kconfig, so it should not cause problems on
> > > non-arch-msm machines.
> > > 
> > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > 
> > Odd, this doesn't apply to the linux-next tree, some of the files are
> > already there.
> 
> Strange, it seems it is almost all already in. Well, good :-).
> 
> But there's small problem. linux-next now contains dwalker's tree, and
> I could not get it to compile, even with staging disabled. I'll need
> to look into that.
> 
> Here are remaining few patches, now easy to read. (It also shows that
> at least CONFIG_AMSS_VERSION and CONFIG_GPIO should really be in
> arch/arm. I believe it will get there in .34 or so...)
> 
> ---
> 
> Guard whole dream/ specific Kconfig with CONFIG_DREAM so that we don't
> cause compile failures in other architectures. Add missing pieces so
> that it compiles.
> 
> I am not sure if this is ready for staging. I guess we should wait
> till I get tree to compile in -next...?

Ok, I'll wait for you to get things building.  Feel free to send the
patch to me after that.

thanks,

greg k-h
