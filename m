From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 28 Jul 2014 23:02:07 -0700
Subject: [GIT PULL] mach-bcm: brcmstb platform support for 3.17
In-Reply-To: <20140728143126.GB2593@beef>
References: <20140722232552.GJ28323@ld-irv-0074> <20140728143126.GB2593@beef>
Message-ID: <20140729060207.GB11952@brian-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 10:31:26AM -0400, Matt Porter wrote:
> I applied all but "ARM: brcmstb: add debug UART for earlyprintk support"
> to mach-bcm for-3.17/[soc|dt]. That patch should also go through
> Russell.

Thanks for the tip. I just submitted the earlyprintk patch to Russel.

> Also, pull requests are fine, but it will help greatly to have pull
> requests split into the appropriate arm-soc categories next time. I
> split these into soc and dt as that is how they need to go to the
> arm-soc team.

Sure thing. In the future, I may just stick with patches, and you can
queue them how you'd like.

Is the arm-soc development process documented somewhere? Like an FAQ, or
ANNOUNCEMENT? [1] I understand that it's a large and noisy subsystem
that warrants some additional processes of its own (beyond what I've
seen in other subsystems), but as a relative newcomer to participating
in it, I've only been able to glean a few bits of info from searching
the LKML/linux-arm-kernel archives.

If not, I'm sure I'll figure things out eventually.

Thanks,
Brian

[1] This comes close. At least it captures the history:

      http://elinux.org/images/a/ad/Arm-soc-checklist.pdf
