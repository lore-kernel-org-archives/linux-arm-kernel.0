From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 11 Oct 2015 19:09:32 +0200
Subject: [PATCH v3 3/5] ARM: sun5i: dt: Move uart3 pinctrl node to common
 DTSI
In-Reply-To: <CAGb2v656+cD__KkFASQ=dPkzE-d2OPoxzU94-yyA8+Y6XQmhiw@mail.gmail.com>
References: <1444380177-15302-1-git-send-email-maxime.ripard@free-electrons.com>
 <1444380177-15302-4-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v656+cD__KkFASQ=dPkzE-d2OPoxzU94-yyA8+Y6XQmhiw@mail.gmail.com>
Message-ID: <20151011170932.GT2278@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 10:22:40PM +0800, Chen-Yu Tsai wrote:
> On Fri, Oct 9, 2015 at 4:42 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The uart3 pins are shared between the A10s and A13, move the pinctrl node
> > to the common DTSI to avoid duplication.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151011/eaa89944/attachment.sig>
