From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 May 2014 15:38:14 +0200
Subject: [PATCH v2] ARM: realview: basic device tree implementation
In-Reply-To: <CACRpkdYE0Fb+HezqgDbVcqQmWwn7QL2+RWSRyAigv2qcMp2qFQ@mail.gmail.com>
References: <1399586896-16906-1-git-send-email-linus.walleij@linaro.org>
 <5678119.IM3FN0FlT6@wuerfel>
 <CACRpkdYE0Fb+HezqgDbVcqQmWwn7QL2+RWSRyAigv2qcMp2qFQ@mail.gmail.com>
Message-ID: <4386397.P7WlMhNVxk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 May 2014 15:04:07 Linus Walleij wrote:
> On Thu, May 22, 2014 at 10:31 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 22 May 2014 09:41:39 Linus Walleij wrote:
> 
> >> The question can be rephrased like this:
> >> Should we create drivers/soc?
> >
> > I think we just did, not sure if the patches have made it into linux-next
> > already, but there were a couple of other platforms already that want this
> > directory.
> 
> Awesomeness. Can you give me the title of a patch or branch
> from ARM SoC I should pull in to build on top of this? Then I can
> split off all the SoC bus business and have the machine file real
> small, nice and clean.

I'd have to check again, it seems that as of today, there is no drivers/soc
on arm-soc yet. I do remember that there were at least two platforms besides
yours that want it though, so we have to coordinate it a bit.

Then again, as I expect all of them to go through arm-soc, we can probably
resolve the conflicts in our tree.

	Arnd
