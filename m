From: tony@atomide.com (Tony Lindgren)
Date: Mon, 11 Mar 2013 10:28:48 -0700
Subject: [PATCH 03/10] ARM: smp_twd: Divorce smp_twd from local timer API
In-Reply-To: <513A8B22.5030008@codeaurora.org>
References: <20130308004011.GD11806@atomide.com>
 <51393B59.3070200@codeaurora.org>
 <20130308180730.GE11806@atomide.com>
 <513A2B20.30805@codeaurora.org>
 <20130308194802.GG11806@atomide.com>
 <513A40EF.8050403@codeaurora.org>
 <20130308200811.GJ11806@atomide.com>
 <513A4774.3040605@codeaurora.org>
 <20130308202947.GK11806@atomide.com>
 <513A8B22.5030008@codeaurora.org>
Message-ID: <20130311172847.GP26093@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Boyd <sboyd@codeaurora.org> [130308 17:10]:
> On 03/08/13 12:29, Tony Lindgren wrote:
> > Applying that does not seem to help, but you might want to get vexpress
> > running anyways for some multiplatform sanity checks.
> >
> > I just built and installed qemu-linaro from their git, then ran the
> > command above. Looks like stock qemu does not work for vexpress for some
> > reason. You can probably use a dummy initrd and rootfs to debug this
> > though :)
> 
> So my patchset didn't break qemu?

Sorry if that was unclear: Yes your patchset breaks booting vexpress
in qemu.

What I meant earlier is that I've ever gotten the qemu-linaro to boot
vexpress and the unpatches qemu did not seem to boot vexpress at all
the last time I tried few months back.

Regards,

Tony
