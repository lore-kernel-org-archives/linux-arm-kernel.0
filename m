From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 13 Mar 2013 19:31:50 +0100 (CET)
Subject: [PATCH] ARM: smp: Allow real broadcast device selection instead
 of always dummy
In-Reply-To: <51409D1D.9000500@ti.com>
References: <1363165608-13739-1-git-send-email-santosh.shilimkar@ti.com>
 <514046B6.9020005@ti.com> <alpine.LFD.2.02.1303131516090.22263@ionos>
 <51409D1D.9000500@ti.com>
Message-ID: <alpine.LFD.2.02.1303131931100.22263@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Mar 2013, Santosh Shilimkar wrote:
> On Wednesday 13 March 2013 07:49 PM, Thomas Gleixner wrote:
> > Though making the rating of the dummy lower is definitely a good
> > thing, so a real hardware device which is detected later can replace
> > the dummy device. So yes, the rating should be low for the dummy
> > timer.
> > 
> Exactly. As Mark pointed out, you have already applied Mark's patch.
> I was just wondering whether you can take the $subject patch as well
> with ack from Russell, Mark.

It can go through the ARM tree as well, no dependencies on my stuff.

Thanks,

	tglx
