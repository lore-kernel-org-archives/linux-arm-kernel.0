From: broonie@kernel.org (Mark Brown)
Date: Mon, 1 Jul 2013 23:38:49 +0100
Subject: [PATCH 3/3] ARM: dts: Add WM1811A audio CODEC to Arndale bindings
In-Reply-To: <CAOMZO5DZb1wWu93eEHkEqNORhm_hn6qy_LdiRSumP7UODJ3uMw@mail.gmail.com>
References: <1372714599-17588-1-git-send-email-broonie@kernel.org>
 <1372714599-17588-3-git-send-email-broonie@kernel.org>
 <CAOMZO5DZb1wWu93eEHkEqNORhm_hn6qy_LdiRSumP7UODJ3uMw@mail.gmail.com>
Message-ID: <20130701223849.GR27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 01, 2013 at 06:47:00PM -0300, Fabio Estevam wrote:
> On Mon, Jul 1, 2013 at 6:36 PM, Mark Brown <broonie@kernel.org> wrote:

> >         i2c at 12C90000 {
> > -               status = "disabled";
> > +               wm1811a at 11 {
> > +                       compatible = "wlf,wm1811";
> > +                       reg = <0x1a>;

> Shouldn't it be reg = <0x11> ? Or wm1811a at 1a ?

The @ should change.  Though since it's one of the bits of ornamental
noise DT has rules for :/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130701/08101330/attachment.sig>
