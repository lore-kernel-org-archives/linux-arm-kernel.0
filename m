From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 9 May 2015 14:19:36 +0200
Subject: [PATCH 3/6] pinctrl: sunxi: Add H3 PIO controller support
In-Reply-To: <554DD0BF.9080108@gmail.com>
References: <1430904693-1404-1-git-send-email-jenskuske@gmail.com>
 <1430904693-1404-4-git-send-email-jenskuske@gmail.com>
 <1430986247.8171.37.camel@x220> <554DD0BF.9080108@gmail.com>
Message-ID: <20150509121936.GW11057@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 09, 2015 at 11:17:51AM +0200, Jens Kuske wrote:
> >> +MODULE_DEVICE_TABLE(of, sun8i_h3_pinctrl_match);
> > 
> >> +MODULE_AUTHOR("Jens Kuske <jenskuske@gmail.com>");
> >> +MODULE_DESCRIPTION("Allwinner H3 pinctrl driver");
> >> +MODULE_LICENSE("GPL");
> > 
> > This adds some module specific boilerplate. Was it perhaps your
> > intention to make PINCTRL_SUN8I_H3 a tristate symbol?
> > 
> 
> I don't know to be honest, I just followed the pattern of all the other
> pinctrl-sun?i-*.c files. But it sounds logical that this is needless
> in the current state.
> 
> Looks like it got introduced when splitting up the driver:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/251712.html
> 
> Maybe there were plans to use separate modules some day. If not, we
> should remove it from the other files as well I guess. Maxime, could
> you please comment on that?

I don't see anything wrong with building those as modules.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150509/678baaea/attachment.sig>
