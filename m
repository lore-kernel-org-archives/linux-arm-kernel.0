From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 2 Sep 2016 21:06:06 +0200
Subject: [PATCH 0/7] drm/sun4i: Introduce A33 display driver
In-Reply-To: <18951472779805@web6g.yandex.ru>
References: <20160901153204.11217-1-maxime.ripard@free-electrons.com>
 <18951472779805@web6g.yandex.ru>
Message-ID: <20160902190605.GF6313@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Icenowy,

On Fri, Sep 02, 2016 at 09:30:05AM +0800, Icenowy Zheng wrote:
> 
> 
> 01.09.2016, 23:40, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> > Hi everyone,
> >
> > This serie introduces the support in the sun4i-drm driver for the A33.
> >
> > Beside the new IPs and special cases for the A33 new IPs, there's
> > nothing really outstanding, and is now at feature parity with the A13.
> 
> How can the driver be modified to support LVDS screen?
> 
> I have an A33 tablet with a 1024x768 LVDS panel. (iNet D978 Rev2 board,
> which I pushed a dt a few days ago)

Awesome, I don't have such a screen myself, so feel free to work on
it.

I haven't looked into the details of LVDS, but it should be something
along the lines of commit 29e57fab97fc ("drm: sun4i: Add RGB output").

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160902/a1772678/attachment.sig>
