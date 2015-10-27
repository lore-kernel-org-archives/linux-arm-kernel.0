From: will.deacon@arm.com (Will Deacon)
Date: Tue, 27 Oct 2015 17:11:03 +0000
Subject: [PATCH v2 10/10] ARM: software-based priviledged-no-access support
In-Reply-To: <20151023084639.GY32532@n2100.arm.linux.org.uk>
References: <20150825154026.GT7557@n2100.arm.linux.org.uk>
 <E1ZUGMS-0000BG-8B@rmk-PC.arm.linux.org.uk>
 <CACRpkdZhJfsH0wU0VBotT=yomDqBkKWrz3MNFOin=CCz62v_nw@mail.gmail.com>
 <20151009105309.GM26278@arm.com>
 <20151009112418.GN32532@n2100.arm.linux.org.uk>
 <CACRpkdb0KavGAQ4XVb1n3P0tZ2Tf9K4EvEtoYCiZ47hKi5MjFA@mail.gmail.com>
 <20151023084639.GY32532@n2100.arm.linux.org.uk>
Message-ID: <20151027171102.GD22049@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2015 at 09:46:40AM +0100, Russell King - ARM Linux wrote:
> On Fri, Oct 23, 2015 at 10:05:06AM +0200, Linus Walleij wrote:
> > Do we have a solution for this?
> > 
> > I'm carrying the patch and v4.3-rc6 is broken on upstream
> > RealView PB11MPCore, at least for me. :(
> 
> Will was going to do some research and get back to me, but what he was
> going to look at has been archived off-site.  Will said he wanted to
> reproduce it on the latest silicon, but I haven't heard anything
> further and he hasn't been around this week.

I'm afraid my digging didn't prove to be very enlightening. One thing I'd
like to try, is to see if we can reproduce the problem on an 11MPCore
platform with a CPU > r0p0. However, I don't have access to such a platform
that can run mainline, so without that I think we have to go with Russell's
workaround predicated on a check for 11MPCore.

Will
