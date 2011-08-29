From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 29 Aug 2011 14:26:55 -0400 (EDT)
Subject: [PATCH v4 00/18] Introduce a led trigger for CPU activity and
	consolidate LED driver in ARM
In-Reply-To: <CAK5ve-+dEc8ie-pFp8e99rrqxAgWeiW3t30JO_sEBqd3BXeZkg@mail.gmail.com>
References: <1314349415-889-1-git-send-email-bryan.wu@canonical.com>
	<CACRpkda6-8dxSbF12N-Q32cOpogu-ZZmTApnvNBa03iOcEeqaQ@mail.gmail.com>
	<CAK5ve-JM=01vTqSi59R6ASyGU_2fVXzKtjNh42LKeF2HF3NzSA@mail.gmail.com>
	<20110829151333.GA17887@n2100.arm.linux.org.uk>
	<CAK5ve-+dEc8ie-pFp8e99rrqxAgWeiW3t30JO_sEBqd3BXeZkg@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1108291424310.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 30 Aug 2011, Bryan Wu wrote:

> On Mon, Aug 29, 2011 at 11:13 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Aug 29, 2011 at 09:18:29PM +0800, Bryan Wu wrote:
> >> Yeah, I replied that email with a patch to select LEDS_CLASS when
> >> CONFIG_NEW_LEDS=y.
> >
> > I don't see any point to that:
> >
> 
> Actually, what I really want to propose is to kill this option and
> build in leds-class.c when CONFIG_NEW_LEDS=y, since most of functions
> of leds-class.c are widely used by others.
> 
> And you know, to select it as default is a simple workaround.

Please go ahead with complete solutions when they exist.  We don't want 
the mainline source tree filled with simple workarounds.


Nicolas
