From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 24 Nov 2017 13:36:01 +0100
Subject: [PATCH v2] ARM: sa1100: simpad: Correct I2C GPIO offsets
In-Reply-To: <CAK8P3a3s-1mD+eVagHBr-YL-nAyr_QN2VZNo7qBn=FZCQfEEkg@mail.gmail.com>
References: <20171107201857.5752-1-linus.walleij@linaro.org>
 <20171110145038.i4jnqsctdzkfmoe5@ninjato>
 <CACRpkdangY192aFpSd1hVaie6A8kY+sASORhR_ncHLYLeUJMWw@mail.gmail.com>
 <CAK8P3a3s-1mD+eVagHBr-YL-nAyr_QN2VZNo7qBn=FZCQfEEkg@mail.gmail.com>
Message-ID: <20171124123601.vyw6vejwa56xmun6@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 10, 2017 at 04:17:26PM +0100, Arnd Bergmann wrote:
> On Fri, Nov 10, 2017 at 4:01 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Fri, Nov 10, 2017 at 3:50 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >
> >> Applied to for-next, thanks!
> >
> > Thanks man.
> >
> >> This from checkpatch makes sense to me:
> >>
> >> ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit b2e63555592f ("i2c: gpio: Convert to use descriptors")'
> >> #21:
> >> commit b2e63555592f81331c8da3afaa607d8cf83e8138
> >
> > I never understood that thingie, I thought the check was
> > only there in order to stop Fixes: tags from running wild.
> > But feel free to cut it if you want.
> 
> I have this in my ~/.gitconfig:
> 
> [core]
>         abbrev = 12
> [alias]
>         fixes = show --format='Fixes: %h (\"%s\")' -s
> 
> So 'git fixes b2e63555592f81331c8da3afaa607d8cf83e8138' produces
> Fixes: b2e63555592f ("i2c: gpio: Convert to use descriptors")
> 
> which I then copy into a changelog as the last line, or use only the reference.

Kinda similar, since I have a white background, I use:

[alias]
lg = log --format='%C(yellow)%h %Cgreen(\"%Creset%s%Cgreen\")'

which is easy on my eye when reading 'git lg' but already has the proper
format when copy pasting its output around.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171124/f2c78282/attachment.sig>
