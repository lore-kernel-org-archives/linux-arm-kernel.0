From: broonie@kernel.org (Mark Brown)
Date: Mon, 19 Oct 2015 19:54:14 +0100
Subject: [alsa-devel] [PATCH v1 1/4] ASoC: codec: Inno codec driver for
 RK3036 SoC
In-Reply-To: <alpine.DEB.2.02.1510190855250.4075@lnxricardw1.se.axis.com>
References: <1444698070-4191-1-git-send-email-zhengsq@rock-chips.com>
 <1444698070-4191-2-git-send-email-zhengsq@rock-chips.com>
 <alpine.DEB.2.02.1510190855250.4075@lnxricardw1.se.axis.com>
Message-ID: <20151019185414.GO32054@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 08:56:51AM +0200, Ricard Wanderlof wrote:
> On Tue, 13 Oct 2015, Shunqian Zheng wrote:

> > +static const struct of_device_id rk3036_codec_of_match[] = {
> > +       { .compatible = "rk3036-codec", },
> > +       {}
> > +};
> > +MODULE_DEVICE_TABLE(of, rk3036_codec_of_match);

> Isn't a compatible string normally in the form "rockchip,rk3036-codec" ?

Yes, it needs vendor namespacing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151019/950c4444/attachment.sig>
