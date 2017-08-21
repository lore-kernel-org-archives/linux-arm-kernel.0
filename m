From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 21 Aug 2017 08:57:32 +0200
Subject: [PATCH] pwm: Convert to using %pOF instead of full_name
In-Reply-To: <CAL_Jsq+Oumkr=Npktxz2RnC9EMf8QWgvaw8SKx1uCLbjQg==Vg@mail.gmail.com>
References: <20170718214339.7774-45-robh@kernel.org>
 <20170725113854.GA22355@ulmo>
 <CAL_Jsq+Oumkr=Npktxz2RnC9EMf8QWgvaw8SKx1uCLbjQg==Vg@mail.gmail.com>
Message-ID: <20170821065732.GI18996@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 09, 2017 at 05:12:55PM -0500, Rob Herring wrote:
> On Tue, Jul 25, 2017 at 6:38 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > On Tue, Jul 18, 2017 at 04:43:25PM -0500, Rob Herring wrote:
> >> Now that we have a custom printf format specifier, convert users of
> >> full_name to use %pOF instead. This is preparation to remove storing
> >> of the full path string for each node.
> >>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >> Cc: Thierry Reding <thierry.reding@gmail.com>
> >> Cc: Carlo Caione <carlo@caione.org>
> >> Cc: Kevin Hilman <khilman@baylibre.com>
> >> Cc: linux-pwm at vger.kernel.org
> >> Cc: linux-arm-kernel at lists.infradead.org
> >> Cc: linux-amlogic at lists.infradead.org
> >> ---
> >>  drivers/pwm/pwm-meson.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Applied, thanks.
> 
> This is not showing up in -next.

Yes, I had forgotten to push this out. I've done that now, so it should
be in the next -next.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170821/338c205e/attachment.sig>
