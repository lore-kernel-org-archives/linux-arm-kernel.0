From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 16 Mar 2015 10:53:30 +0000
Subject: [PATCH 0/4] arm64: boot fixes/updates
In-Reply-To: <CAKv+Gu_CDJu5Wx3uEU4Qv4_d1350n0hNnQye147gH4a=Qcow_w@mail.gmail.com>
References: <1426263277-9827-1-git-send-email-mark.rutland@arm.com>
 <CAKv+Gu_CDJu5Wx3uEU4Qv4_d1350n0hNnQye147gH4a=Qcow_w@mail.gmail.com>
Message-ID: <20150316105330.GC15066@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 14, 2015 at 07:59:02AM +0000, Ard Biesheuvel wrote:
> On 13 March 2015 at 17:14, Mark Rutland <mark.rutland@arm.com> wrote:
> > Hi all,
> >
> > The following patches address a few boot related issues I spotted
> > recently.
> >
> > The first patch fixes alternatives for !SMP kernels, the second fixes a
> > potential issue with boot mode detection, and the final patches give us
> > some better logging of the boot mode, fixing a latent bug in mismatch
> > detection (though until now this has not been a problem).
> >
> > Ard, Marc, I guess our recent boot patches are all going to clash. Do we
> > need to sort that out between us or are we relying on the arm64
> > maintainers? ;)
> >
> 
> Seems we spotted and fixed the same bug at the same time :-)
> (but I failed to put you on cc)
> 
> http://article.gmane.org/gmane.linux.ports.arm.kernel/400100

Haha. Your patch looks good to me, so I've given it my Ack. :)

> I can stick all of our patches on a branch for Will to pull, if people
> are ok with that?

That sounds fine by me.

> I need another couple of acks though

Understood.

Mark.
