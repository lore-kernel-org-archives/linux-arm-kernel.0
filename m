From: maxime.ripard@free-electrons.com ('Maxime Ripard')
Date: Tue, 16 Jul 2013 17:46:16 +0200
Subject: [PATCH 3/3] fb: backlight: HX8357: Add HX8369 support
In-Reply-To: <003601ce81c8$c2573320$47059960$@samsung.com>
References: <1373902022-20439-1-git-send-email-maxime.ripard@free-electrons.com>
 <1373902022-20439-4-git-send-email-maxime.ripard@free-electrons.com>
 <003601ce81c8$c2573320$47059960$@samsung.com>
Message-ID: <20130716154616.GK3125@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jingoo,

On Tue, Jul 16, 2013 at 11:04:09AM +0900, Jingoo Han wrote:
> On Tuesday, July 16, 2013 12:27 AM, Maxime Ripard wrote:
> > 
> > From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > 
> > Add support for the Himax HX8369 controller as it is quite similar to the
> > hx8357.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Hi Maxime Ripard,
> 
> I reviewed this patch with Himax HX8369 datasheet.
> I cannot find any problems. It looks good.
> 
> However, if possible, please add comment on huge delays such as
> msleep(120), msleep(100), etc.

Right. I'll send a follow-up patch if this is merged right away, or
merge the comments in the next iteration of the patches.

> Acked-by: Jingoo Han <jg1.han@samsung.com>

Thanks for taking the time to review this!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130716/67432efb/attachment.sig>
