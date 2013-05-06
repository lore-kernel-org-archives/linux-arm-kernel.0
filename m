From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 6 May 2013 22:19:22 +0200
Subject: Fwd: Tegra 30 System hangs because of commit "pinctrl: move
 subsystem mutex to pinctrl_dev struct"
In-Reply-To: <51880F2F.8010102@wwwdotorg.org>
References: <517ED12B.8080502@wwwdotorg.org>
 <20130504133004.GC24282@game.jcrosoft.org>
 <CACRpkdbBVJtWrRO+J=pWjfLXTcVKX++x-eeJQXGeQn_WOURUNQ@mail.gmail.com>
 <20130505112819.GD24282@game.jcrosoft.org>
 <CACRpkdZdT8==cUtH4=Y3LC-eVu6ntO2ojFC4bSXNuxa4hMJ=ZA@mail.gmail.com>
 <20130505202236.GF24282@game.jcrosoft.org>
 <CACRpkda2EG0O-pfZQ5kLFX=cwSmUSVBJkR7Xvye3ROs3tstv9w@mail.gmail.com>
 <20130506194122.GG24282@game.jcrosoft.org>
 <20130506195403.GJ18614@n2100.arm.linux.org.uk>
 <51880F2F.8010102@wwwdotorg.org>
Message-ID: <20130506201922.GH24282@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:14 Mon 06 May     , Stephen Warren wrote:
> On 05/06/2013 01:54 PM, Russell King - ARM Linux wrote:
> > On Mon, May 06, 2013 at 09:41:22PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >> On 21:29 Mon 06 May     , Linus Walleij wrote:
> >>> On Sun, May 5, 2013 at 10:22 PM, Jean-Christophe PLAGNIOL-VILLARD
> >>> <plagnioj@jcrosoft.com> wrote:
> >>>
> >>>> I was thinking to put a jenkins to test Linus HEAD all the time
> >>>> And with some automatic test one some hw
> >>>>
> >>>> to detect it more quick
> ...
> > My conclusion is that build and boot test systems just don't work in an
> > open source environment as no one actively checks the results.  Why would
> > they - maintainers already have enough to do with reading 6500+ emails a
> > month on mailing lists.  Why bother going to look at a website as well
> > which might give even more work.
> 
> Couldn't such a system email people pro-actively, so nobody had to do
> any manual checking? The kisskb(?) build system does that, as does the
> "zero day build system" thing from Intel, and I find them quite useful.
> Personally, I do the build/test checks manually myself, so if an
> automated system were to do it, it'd save me work rather than give me
> more work.

I've one on at91 but not on all HW but as Russell I need to check manualy

and yes I agreewe should have such automatic tool could be easly be integrated
in Jenkins and send automatic emails

It's really a shamge that no-one is intrested in such tools. I will all save a
huge amount of time of boring basic testing

Best Regards,
J.
