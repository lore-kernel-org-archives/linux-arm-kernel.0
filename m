From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Oct 2013 08:10:15 -0700
Subject: [PATCH 3/6] pinctrl: single: Prepare for supporting SoC
 specific features
In-Reply-To: <CACRpkdZ1CeSXJngo0gKpnag-=mT3FB-byJi3JSAWiS8hbHqBJA@mail.gmail.com>
References: <20131003054104.8941.88857.stgit@localhost>
 <20131003054218.8941.19273.stgit@localhost>
 <20131007173531.GX8949@atomide.com>
 <CACRpkdZ1CeSXJngo0gKpnag-=mT3FB-byJi3JSAWiS8hbHqBJA@mail.gmail.com>
Message-ID: <20131009151015.GZ8313@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [131009 06:51]:
> On Mon, Oct 7, 2013 at 7:35 PM, Tony Lindgren <tony@atomide.com> wrote:
> 
> > Hi Linus W,
> >
> > Any comments on the pinctrl patches 3 - 5 in this series?
> 
> Yes, after good explanations to my whimsical questions only this:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

OK thanks :)
 
> I guess you'll take these patches through ARM SoC?

I was thinking I'll set up an immutable branch for the three
pinctrl patches against -rc4 then both you and I can merge
them in as needed. Does that work for you?

I can also do a test merge with pinctrl/for-next also to make
sure there are no conflicts.

The rest of the patches should not be needed in the pinctrl
branch, but I need them all in one branch to keep things
working.

Regards,

Tony
