From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 May 2013 20:54:03 +0100
Subject: Fwd: Tegra 30 System hangs because of commit "pinctrl: move
 subsystem mutex to pinctrl_dev struct"
In-Reply-To: <20130506194122.GG24282@game.jcrosoft.org>
References: <CAK5ve-KXdS8az=Gtja-mF=Z3_EeZVA7bLYSU0EE2mf5bHmSUKw@mail.gmail.com>
 <CAK5ve-KBDyvjNRVMcXgfnhYcajdcGsuAKaepzCBt+epiXoYvSw@mail.gmail.com>
 <517ED12B.8080502@wwwdotorg.org> <20130504133004.GC24282@game.jcrosoft.org>
 <CACRpkdbBVJtWrRO+J=pWjfLXTcVKX++x-eeJQXGeQn_WOURUNQ@mail.gmail.com>
 <20130505112819.GD24282@game.jcrosoft.org>
 <CACRpkdZdT8==cUtH4=Y3LC-eVu6ntO2ojFC4bSXNuxa4hMJ=ZA@mail.gmail.com>
 <20130505202236.GF24282@game.jcrosoft.org>
 <CACRpkda2EG0O-pfZQ5kLFX=cwSmUSVBJkR7Xvye3ROs3tstv9w@mail.gmail.com>
 <20130506194122.GG24282@game.jcrosoft.org>
Message-ID: <20130506195403.GJ18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 06, 2013 at 09:41:22PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 21:29 Mon 06 May     , Linus Walleij wrote:
> > On Sun, May 5, 2013 at 10:22 PM, Jean-Christophe PLAGNIOL-VILLARD
> > <plagnioj@jcrosoft.com> wrote:
> > 
> > > I was thinking to put a jenkins to test Linus HEAD all the time
> > > And with some automatic test one some hw
> > >
> > > to detect it more quick
> > 
> > Hm yeah, I think I need a broader diversity of testsystems too ... I have this
> > nice Chromebook so I thought if I could get a mainline kernel running on
> > it I'd have a bigger coverage as well.
> 
> Maybe we could all work together to setup such automatic testing tool
> 
> I mean all vendors

Don't bother.  We had one, Simtec's Vince Sanders gave us the build side.
No one was interested.  No one took any notice of it.  I have one for a
limited number of platforms - it even boots the resulting kernels on real
hardware.  The only person who looks at it is me.  Again, just one person,
so little value.

And that same thing will appy to anything else setup by anyone else.

It's a good idea, but it only really works if people can be bothered to
derive value from it by checking the results.

My conclusion is that build and boot test systems just don't work in an
open source environment as no one actively checks the results.  Why would
they - maintainers already have enough to do with reading 6500+ emails a
month on mailing lists.  Why bother going to look at a website as well
which might give even more work.
