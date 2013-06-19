From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 19 Jun 2013 21:51:31 +0200
Subject: [PATCH v2 2/2] gpio-rcar: Remove #ifdef CONFIG_OF around
 OF-specific sections
In-Reply-To: <CACRpkda+rw802mrdXYvcQRO0qy8hLmid7pdQwg4z=YvH6EY+Aw@mail.gmail.com>
References: <1371551389-5493-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1371551389-5493-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CACRpkda+rw802mrdXYvcQRO0qy8hLmid7pdQwg4z=YvH6EY+Aw@mail.gmail.com>
Message-ID: <1667096.lqpXoD2UlE@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Wednesday 19 June 2013 21:17:35 Linus Walleij wrote:
> On Tue, Jun 18, 2013 at 12:29 PM, Laurent Pinchart wrote:
> > All functions and data types used by OF-specific code paths are declared
> > in <linux/of.h> regardless of CONFIG_OF. Replace the #ifdef CONFIG_OF
> > guard with a if(IS_ENABLED(CONFIG_OF)) and let the compiler optimize
> > the unused code away.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thank you. Can you please take the patch in your tree ?

-- 
Regards,

Laurent Pinchart
