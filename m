From: mchehab@s-opensource.com (Mauro Carvalho Chehab)
Date: Thu, 25 Aug 2016 09:41:14 -0300
Subject: [PATCH v4 4/6] media: rc: meson-ir: Add support for newer
 versions of the IR decoder
In-Reply-To: <7hy43s5r7d.fsf@baylibre.com>
References: <20160628191802.21227-1-martin.blumenstingl@googlemail.com>
 <20160819215547.20063-1-martin.blumenstingl@googlemail.com>
 <20160819215547.20063-5-martin.blumenstingl@googlemail.com>
 <7hy43s5r7d.fsf@baylibre.com>
Message-ID: <20160825094114.2ca0a9e9@vento.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Fri, 19 Aug 2016 15:28:22 -0700
Kevin Hilman <khilman@baylibre.com> escreveu:

> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
> 
> > From: Neil Armstrong <narmstrong@baylibre.com>
> >
> > Newer SoCs (Meson 8b and GXBB) are using REG2 (offset 0x20) instead of
> > REG1 to configure the decoder mode. This makes it necessary to
> > introduce new bindings so the driver knows which register has to be
> > used.
> >
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>  
> 
> Acked-by: Kevin Hilman <khilman@baylibre.com>
> 
> Mauro, are you the one to pick up new media/rc drivers?  Or if you
> prefer, with your ack, I'll take this along with the DT and submit via
> arm-soc.

I generally pick new media rc drivers, but in the specific case of this
patchset, it is just adding a few extra lines to existing drivers, and
most of the work are actually at the ARM tree.

So, feel free to merge via arm-soc with my ack:

Acked-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>

> 
> Thanks,
> 
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



Thanks,
Mauro
