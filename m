From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 30 Aug 2011 00:32:23 -0400 (EDT)
Subject: [RFC] Kbuild: allow code re-use across different directories
In-Reply-To: <CACqU3MVrSV-Qp7mC4iN_viMHz=2-cGPaqNY04eokYkVoE_pSuw@mail.gmail.com>
References: <1313800642-32418-1-git-send-email-lacombar@gmail.com>
	<CACqU3MVrSV-Qp7mC4iN_viMHz=2-cGPaqNY04eokYkVoE_pSuw@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1108300028470.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 29 Aug 2011, Arnaud Lacombe wrote:

> On Fri, Aug 19, 2011 at 8:37 PM, Arnaud Lacombe <lacombar@gmail.com> wrote:
> > With the attached patch, we would do:
> >
> > arch/foo/boot/Makefile:
> > LDFLAGS_fancy.o := -DPANTS=30
> > obj-y += fancy.o
> > vpath-y += $(srctree)/arch/foo/lib
> >
> > and let GNU make do the job.
> >
> Nicolas, I guess you were the one who was interested for a generic way
> to do such code re-use, did you had any chance to test the quoted
> patch ?

I actually missed the original post (I wasn't in CC) so I didn't test it. 
Will try to do so ASAP.


Nicolas
