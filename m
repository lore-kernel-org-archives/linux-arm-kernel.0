From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 20 Sep 2013 21:57:44 +0200
Subject: [PATCH/RESEND 1/2] gpio: rcar: Remove #gpio-range-cells DT
 property usage
In-Reply-To: <20130920190614.GF22321@verge.net.au>
References: <1378907462-19247-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CACRpkdZ4EaUVgYoMP6VMefZgE1T--5hh18RzupQLnbd0KpveAA@mail.gmail.com>
 <20130920190614.GF22321@verge.net.au>
Message-ID: <1566063.hFmS6D0Ff2@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Friday 20 September 2013 12:06:14 Simon Horman wrote:
> On Fri, Sep 20, 2013 at 08:36:57PM +0200, Linus Walleij wrote:
> > On Wed, Sep 11, 2013 at 3:51 PM, Laurent Pinchart
> > 
> > <laurent.pinchart+renesas@ideasonboard.com> wrote:
> > > Commit a1bc260bb5f5d95da854be7898202d788e94448d ("gpio: clean up
> > > gpio-ranges documentation") deprecated the #gpio-range-cells property.
> > > Replace its usage with a hardcoded value in the gpio-rcar driver.
> > > 
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > 
> > Simon please take the whole set into the SH tree.
> 
> Thanks, will do.

Just a quick reminder that the two patches are v3.12 fixes. Would you like me 
to send you a pull request ?

-- 
Regards,

Laurent Pinchart
