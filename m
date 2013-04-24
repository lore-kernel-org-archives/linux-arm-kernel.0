From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 23 Apr 2013 23:48:31 -0300
Subject: [RFC][PATCH] video: imx: Select VIDEOMODE_HELPERS
In-Reply-To: <1366702862.4365.2.camel@pizza.hi.pengutronix.de>
References: <1366666110-9585-1-git-send-email-marex@denx.de>
 <CAOMZO5Av8RyptoxAQ13Psxjjd4nhHVbEJoVm6SqyLr55bPmSng@mail.gmail.com>
 <201304230157.47992.marex@denx.de>
 <1366702862.4365.2.camel@pizza.hi.pengutronix.de>
Message-ID: <CAOMZO5DtupVZv0iUtEptEoi2QJzddiwjq=vw9iZyBQhpcvVwHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Tue, Apr 23, 2013 at 4:41 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:

> OF_VIDEOMODE is the correct one. The implementation of
> of_get_drm_display_mode in drivers/gpu/drm/drm_modes.c depends on it.

The symbol OF_VIDEOMODE has been deprecated.

Regards,

Fabio Estevam
