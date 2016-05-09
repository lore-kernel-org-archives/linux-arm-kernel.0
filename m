From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 May 2016 16:27:00 +0200
Subject: [GIT PULL] move ARM LCD display driver to auxdisplay
In-Reply-To: <20160509161728.3aee1134@erd979>
References: <CACRpkdbyO0axd5ergYZcXO302f2fFAPKrSNevkvreP1kRjm-vw@mail.gmail.com>
 <20160425115758.GA4874@lukather>
 <CACRpkdb=s5onVa7qND9nFUtYPw5H-Hdr7Ja5o3=-9+wxghHekQ@mail.gmail.com>
 <20160428092608.GE17159@lukather> <5723755D.9060108@ti.com>
 <20160509090615.6272f8ca@erd979>
 <CACRpkdbZmL9Cqp-ubzyxd7fWUFOVsS1DCxsfG02kSpbWu_rbZQ@mail.gmail.com>
 <20160509161728.3aee1134@erd979>
Message-ID: <CACRpkdZwPVMx-dXVkfVwFN0juzVuyvShV7yDWbUFSXOPE=uUrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 9, 2016 at 4:17 PM, Robin van der Gracht <robin@protonic.nl> wrote:
> On Mon, 9 May 2016 15:19:26 +0200
> Linus Walleij <linus.walleij@linaro.org> wrote:
>
>> On Mon, May 9, 2016 at 9:06 AM, Robin van der Gracht
>> <robin@protonic.nl> wrote:
>>
>> > If you guys feel like auxdisplay is not the right subsystem for the
>> > driver, and would like me to move it, please share.
>>
>> The best would be if you volunteer to maintain it and bring
>> it forward.
>
> Thats fine. Would it suffice if I submit another patch adding myself
> to the maintainers file?

That's half of it, if Miguel does not come back then his name
should be removed as the second step.

You also need to have an idea on a path to funnel accumulated
patches upstream to Torvalds. The recent patches to this
subsystem were funneled by Greg, so we should ask him how
he prefer to proceed.

Greg, what do you prefer?

Yours,
Linus Walleij
