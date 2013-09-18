From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 18 Sep 2013 15:30:25 +0200
Subject: [PATCH 1/4] usb: musb: Call atomic_notifier_call_chain when
 status is changed
In-Reply-To: <CAAwP0s1Ou7Nrq7GhnHX71TFCrTFg=nqUh+GsAJhN8DjZGsF4QQ@mail.gmail.com>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <201309172128.42514@pali> <20130918014942.GD19817@radagast>
 <201309181020.15245@pali>
 <CAAwP0s1Ou7Nrq7GhnHX71TFCrTFg=nqUh+GsAJhN8DjZGsF4QQ@mail.gmail.com>
Message-ID: <20130918133025.GB2953@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >> > So will you do that? Or it is needed to resend this one line
> >> > hunk again in new email again?
> >>
> >> new patch, new email
> >
> > Guys, WHY ARE YOU SO STUPID AND ARROGANT?
> >
> > Sorry but, need to copy full isolated patch/hunk from one mail to
> > another is hassling. So what you want from me? Do all those non
> > sense working only because yesterday you had bad day? Or what?
...
> 
> Hi Pali,
> 
> There is no need to be rude.
> 
> Felipe asked you to do the split since he believes that the notifier
> chain call for musb xceiv and the twl->phy notifier head init should
> be done in two separate patches.

Actually, there is need to be rude, because Felipe fails to act as
maintainer. Instead of fixing bugs in his code, he bounces bugfix
patches, points people to random READMEs and wastes everyones time.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
