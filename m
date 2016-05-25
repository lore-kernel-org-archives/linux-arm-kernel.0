From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 May 2016 18:29:45 +0200
Subject: [PATCH 12/20] drm/sun4i: Add bridge support
In-Reply-To: <CAKMK7uG-uq7XSqyesVnPtx0Ajx-FQjVKm_QzjEZgWJQDn8EkPA@mail.gmail.com>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
 <1463402840-17062-13-git-send-email-maxime.ripard@free-electrons.com>
 <CAKMK7uG-uq7XSqyesVnPtx0Ajx-FQjVKm_QzjEZgWJQDn8EkPA@mail.gmail.com>
Message-ID: <20160525162945.GK9232@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Mon, May 16, 2016 at 03:12:15PM +0200, Daniel Vetter wrote:
> On Mon, May 16, 2016 at 2:47 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Our RGB bus can be either connected to a bridge or a panel. While the panel
> > support was already there, the bridge was not.
> >
> > Fix that.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> For bridge support the only thing you need is to set
> drm_encoder->bridge. Why do you need to hand-roll your own bridge
> support? That pretty muchmeans you'll do it slightly differently (e.g.
> you don't bother with a lot of the calls), which will make sharing
> bridge drivers ever so harder. And also reviewing code, since using
> shared code but slightly differently is really confusing.

Because I overlooked it :)

I'll change that.

Thanks!
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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160525/56a7f4a6/attachment-0001.sig>
