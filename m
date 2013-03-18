From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 18 Mar 2013 14:40:24 +0800
Subject: [RFC 0/3] arm: mxs: sanitize enet_out clock handling
In-Reply-To: <CA+7tXiinVCjs7NAdGd+0KyUL+kfwWUi_XAPYdMHiugT3W2Xz4w@mail.gmail.com>
References: <1359470773-14290-1-git-send-email-w.sang@pengutronix.de>
 <CA+7tXiinVCjs7NAdGd+0KyUL+kfwWUi_XAPYdMHiugT3W2Xz4w@mail.gmail.com>
Message-ID: <20130318064021.GA4713@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 15, 2013 at 02:27:35PM -0700, Trent Piepho wrote:
> But as you say most boards need enet_out (AFAICT, all but the Denx
> board).  So wouldn't it make more sense to add enet_out to the dtsi
> file and then just override it in the one board that doesn't need it,
> instead of overriding in every board except that one?

Yes, sounds reasonable.  Since I'm not sure Wolfram is still interested
in the work, I will pick it up from here.

Shawn
