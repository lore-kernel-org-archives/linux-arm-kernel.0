From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Mar 2015 08:15:55 -0700
Subject: [PATCH v6 2/6] wl12xx: use frequency instead of enumerations for
 pdata clocks
In-Reply-To: <87lhixphag.fsf@kamboji.qca.qualcomm.com>
References: <1426162154-8716-1-git-send-email-eliad@wizery.com>
 <20150313150047.GI5264@atomide.com>
 <CAB3XZEcOytqpJ4pWoemLS3d+DCeA8C75MencDfGn_vhfEYrduw@mail.gmail.com>
 <3103538.jZ037SODdT@wuerfel>
 <87lhixphag.fsf@kamboji.qca.qualcomm.com>
Message-ID: <20150316151554.GO5264@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kalle Valo <kvalo@codeaurora.org> [150315 23:50]:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > On Sunday 15 March 2015 10:43:35 Eliad Peller wrote:
> >> 
> >> > The other option would be to have the whole series in a immutable
> >> > branch against v3.0-rc1 that can be merged into both wirelss tree
> >> > and omap tree.
> >> >
> >> i think that could be easier.
> >> 
> >> or maybe you can just take them all through the omap tree? the wlcore
> >> tree is not under active development, so i don't expect conflicts
> >> there.
> >
> > I'm fine with both these approaches.
> 
> I prefer these going through the omap tree. Like Eliad said,
> drivers/net/wireless/ti does not get that many changes nowadays so the
> chances of this patchset conflicting with something is very small.

OK great. In that case no need to rearrange the patches, I can
apply them into an immutable branch once the pending issues have
been fixed if Kalle acks them.

To avoid merge conflicts that branch is easiest done against
v4.0-rc4. Kalle and Arnd, does that work for you guys?

I can also base it on 5b7610f23562 ("ARM: OMAP2+: Fix wl12xx on
dm3730-evm with mainline u-boot") that's on top of -rc2 plus few
other fixes now merged to -rc4 mainline if we need a branch based
on an earlier tag.

Regards,

Tony
