From: tony@atomide.com (Tony Lindgren)
Date: Tue, 22 Dec 2015 17:47:57 -0800
Subject: [GIT PULL 2/4] omap changes for ti81xx devices and minimal
 dra62x j5eco-evm support
In-Reply-To: <CAOesGMjKaRcTHQ40p0pMUW-z1o9HZqEmon3fsFKe46QX82+gDA@mail.gmail.com>
References: <567869f7.9440620a.dbdb.65d1SMTPIN_ADDED_BROKEN@mx.google.com>
 <20151222225331.GI30172@localhost>
 <20151222233343.GI2793@atomide.com>
 <CAOesGMjKaRcTHQ40p0pMUW-z1o9HZqEmon3fsFKe46QX82+gDA@mail.gmail.com>
Message-ID: <20151223014756.GJ2793@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Olof Johansson <olof@lixom.net> [151222 15:41]:
> On Tue, Dec 22, 2015 at 3:33 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Olof Johansson <olof@lixom.net> [151222 14:58]:
> >>
> >> I'm a little puzzled by how you chose to organize this branch. We usually
> >> ask for SoC enablement and new DT files separately. Is there a reason you
> >> couldn't split out the SoC pieces and include those in the soc branch, and
> >> leave the DT contents for this one?
> >
> > Hmm yeah I guess I kept all the 81xx stuff in a single branch because of the
> > earlier largeish set of 81xx fixes that had interlaced dts and SoC changes
> > that had to be in a specific order to keep system booting because of bugs in
> > the dts defined clocks.
> >
> > If you want to, I can respin these patches into two branches, one for dts and
> > one for SoC changes. Probably both branches have to be based on the earlier
> > branch "omap-for-v4.5/81xx-fixes-signed" to avoid merge conflicts though.
> 
> Yeah, that sounds good. Please do.

OK updated pull requests sent. It's now three separate pull requests starting
with "[GIT PULL 1/3] reworked fix for earlier ti81xx changes for v4.5 merge
window".

Regards,

Tony
