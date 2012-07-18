From: olof@lixom.net (Olof Johansson)
Date: Tue, 17 Jul 2012 20:54:31 -0700
Subject: [PULL] [PATCH 0/4] arm: at91: gpio fix
In-Reply-To: <20120715131618.GF4450@game.jcrosoft.org>
References: <20120715131618.GF4450@game.jcrosoft.org>
Message-ID: <CAOesGMgXAADDqAL5EvSdfaO0GzZJT0_a7-eNRPTJA73zYN-TEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Christophe,

Comments below. As I mentioned in the SPEAr pull request just now, we
are very close to final 3.5, so only fixes to bugs should go in.
Please help me out a bit below.

On Sun, Jul 15, 2012 at 6:16 AM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:

> Jean-Christophe PLAGNIOL-VILLARD (4):
>       ARM: at91: gpio: implement request
>       ARM: at91: gpio: implement gpio_free

Are the two above regressions, or just general improvement? Looks like
the latter to me?

>       at91: regroup gpio and pinctrl under a simple-bus

This looks like a cleanup patch to me. I'm also not sure that this is
appropriate use of a simple-bus. The patch seems to have been posted
for review the same day as you sent the pull request, and not cc:d to
devicetree-discuss.

>       arm: at91: at91sam9x5: fix gpio number per bank

Ok, this one I can believe is a proper fix.

So, please let me know if I should just cherry-pick in the last patch
and include that in the last 3.5 pull request, or if you want to
respin the branch. Also, if any of the other patches are truly 3.5
material, I'd like to hear a bit more motivation as to why.


Thanks!


-Olof
