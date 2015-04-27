From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 27 Apr 2015 11:16:17 +0200
Subject: [PATCH v5 0/3] Fix lubbock and mainstone interrupts
In-Reply-To: <87pp6rkzha.fsf@belgarion.home>
References: <1429996403-13644-1-git-send-email-robert.jarzmik@free.fr>
 <7247485.mMzWTjWY84@wuerfel> <87pp6rkzha.fsf@belgarion.home>
Message-ID: <5225589.tkUhR6vGoM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 26 April 2015 11:31:13 Robert Jarzmik wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > On Saturday 25 April 2015 23:13:20 Robert Jarzmik wrote:
> >> This serie was submitted to the lak list, then migrated to mfd drivers, to end
> >> up again here. There was no change since last submission. Let's hope this is the
> >> last spin and that these platform will be fixed at last.
> >> 
> >
> > Should these be marked 'Cc: stable at vger.kernel.org'?
> I can do this. I thought that 3 patches of 100+ lines, and the fact that these
> boards were broken since october 2011 would prevent this serie from reaching the
> stable branch.
> 
> Well, I'll resubmit with this information, and after comments stage it to my
> fixes branch. Let's see what stable tree people will do.
> 
> > Can you also add a 'Fixes' tag with the commit that introduced the problem?
> Sure.

You are right about the size limit, I didn't see how big the patches
actually are. In this case, leave the 'Fixes' tag, but don't add
the Cc to stable.

	Arnd
