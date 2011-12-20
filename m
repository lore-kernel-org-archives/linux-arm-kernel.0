From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 Dec 2011 20:52:07 -0800
Subject: [GIT PULL] Borderline fixes for v3.2-rc6
In-Reply-To: <20111219194249.GO6464@atomide.com>
References: <20111219194249.GO6464@atomide.com>
Message-ID: <CAOesGMj-OyDu9pcOZ20o6G0W3-kkxyHF7o5DqDRaQkkUDf98CA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Mon, Dec 19, 2011 at 11:42 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hi Arnd & Olof,
>
> Here are two fixes that could potentially go into v3.2 -rc cycle.
>
> One fixes a harmless but annoying warning that happens on omap 34xx
> processors during boot. The other one fixes booting on pretty rare
> secure mode development board, but that's fixed in "features that
> never worked earlier either" style.
>
> We can surely wait on these fixes, but if you have something going
> upstream anyways, then these might be worth considering too.

The hwmod patch is a regression so that one I'll take, the other one
is a little less obvious that it should go in now. Also, shouldn't it
be cc:d stable in that case?

Let me know what you prefer (rebase with a cc: stable) or take out the
secure mode patch. I'm collecting a small series of fixes so I'll pull
it in tomorrow for that.


-Olof
