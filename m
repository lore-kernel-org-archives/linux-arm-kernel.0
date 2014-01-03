From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 3 Jan 2014 01:28:05 -0200
Subject: [PATCH] ARM: imx: Explicitly pass the active level of the PHY
 reset
In-Reply-To: <20140103032230.GC25079@S2101-09.ap.freescale.net>
References: <1388715253-17206-1-git-send-email-festevam@gmail.com>
 <20140103032230.GC25079@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5CZnx9Pi79eufO5uCM7uyvKR6r0VULE9dpwfZBAPpdj7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Fri, Jan 3, 2014 at 1:22 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> If this is needed for 3.13, you should generate the patch against the
> mainline where the fec change is in place rather than my for-next
> branch.  And for those dts files that can only be patched against my
> for-next branch, we need another patch.

If this patch goes via your for-next there will be no harm to your
tree, since the fec driver will just ignore the gpio flag and the
behaviour will be the same as before.

If you are not happy with it, then I will have to generate the patch
against mainline and ask davem to apply it.

Regards,

Fabio Estevam
