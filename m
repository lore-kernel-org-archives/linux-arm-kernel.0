From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 6 Nov 2015 16:35:10 -0800
Subject: [linux-sunxi] [PATCH 11/19] drm: sun4i: Add composite output
In-Reply-To: <CANwerB0tva90mj7Anits0gfecQuLcDZ-BEctc0VNAY+Oq0dLbA@mail.gmail.com>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
 <1446214865-3972-12-git-send-email-maxime.ripard@free-electrons.com>
 <CANwerB0tva90mj7Anits0gfecQuLcDZ-BEctc0VNAY+Oq0dLbA@mail.gmail.com>
Message-ID: <20151107003510.GR6114@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 02, 2015 at 01:53:20PM +1100, Jonathan Liu wrote:
> > +       ret = sun4i_tv_init(drm);
> > +       if (ret) {
> > +               dev_err(drm->dev, "Couldn't create our RGB output\n");
> 
> RGB should be composite. Seems like a copy-paste error.

Good catch. Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151106/7855b955/attachment.sig>
