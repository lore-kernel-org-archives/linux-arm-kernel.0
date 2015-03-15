From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 15 Mar 2015 13:08:54 +0100
Subject: [PATCH v6 2/6] wl12xx: use frequency instead of enumerations for
 pdata clocks
In-Reply-To: <CAB3XZEcOytqpJ4pWoemLS3d+DCeA8C75MencDfGn_vhfEYrduw@mail.gmail.com>
References: <1426162154-8716-1-git-send-email-eliad@wizery.com>
 <20150313150047.GI5264@atomide.com>
 <CAB3XZEcOytqpJ4pWoemLS3d+DCeA8C75MencDfGn_vhfEYrduw@mail.gmail.com>
Message-ID: <3103538.jZ037SODdT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 15 March 2015 10:43:35 Eliad Peller wrote:
> 
> > The other option would be to have the whole series in a immutable
> > branch against v3.0-rc1 that can be merged into both wirelss tree
> > and omap tree.
> >
> i think that could be easier.
> 
> or maybe you can just take them all through the omap tree? the wlcore
> tree is not under active development, so i don't expect conflicts
> there.

I'm fine with both these approaches.

	Arnd
