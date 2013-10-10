From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Oct 2013 10:32:11 -0700
Subject: [RFCv3 0/7] OMAP SSI driver
In-Reply-To: <20131010172128.GF28657@earth.universe>
References: <1381091235-18293-1-git-send-email-sre@debian.org>
 <20131008172815.GA8313@atomide.com>
 <20131010172128.GF28657@earth.universe>
Message-ID: <20131010173211.GH29913@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Reichel <sre@debian.org> [131010 10:30]:
> Hi,
> 
> On Tue, Oct 08, 2013 at 10:28:15AM -0700, Tony Lindgren wrote:
> > * Sebastian Reichel <sre@debian.org> [131006 13:36]:
> > > Here is the third round of the OMAP SSI driver patches.
> > 
> > Thanks for updating these, they look good to me now:
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Ok. I guess it's time to check how this gets included in the kernel.
> 
> The first patch has already been queued and the last patch could
> probably go through Beno?t once the DT people have reviewed the
> updated patches. The other ones would normally go through the
> hsi tree, but that one was maintained by Carlos Chinea and is 
> now more or less orphaned.

Yes, I suggest you post the .dts changes completely seprately
so driver maintainers don't accidentally pick those up.
 
> My suggestion is:
> 
> 1. I create another patch, which adds entries for hsi subsystem and
>    ssi driver to MAINTAINERS.
> 
>    It would be nice to have some co-maintainers for the subsystem.
>    Linus Walleij maybe? I think you created the launchpad blueprint [1]?
>    Especially because I have no documentation/specification for HSI, which
>    brings me to my next slightly off topic request.
> 
>    I would like to have access to SSI documentation and HSI specification.
>    Can the guys from Texas Instruments please give me some pointers how I
>    can get access to the NDA'd documentation? I couldn't find any hints
>    on ti.com.
> 
> 2. I create a patch adding Carlos Chinea to CREDITS
> 
> 3. I create a git repository and put all of the patches in there, so
>    that they can be pulled into linux-next.
> 
> 4. I add a gpg/pgp signed tag with the key used to signed this mail.
> 
> Any issues with this or any other suggestions how to proceed? And if following this
> - should I request an account on kernel.org to host the repository there,
> or should I just upload it at a random place?

That all sounds good to me. It is a *good thing* to have a maintainer
for a driver subsystem, and if you're willing to pick it up, that's
the way to go.

Regards,

Tony
 
> [0] https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/Next/Trees
> [1] https://blueprints.launchpad.net/linux-linaro/+spec/hsi-subsystem-maint
> 
> -- Sebastian
