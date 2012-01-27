From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 27 Jan 2012 12:56:31 -0200
Subject: [PATCH] ARM: mx28: clock-mx28: Use a proper timeout mechanism
In-Reply-To: <20120126122805.GC3523@S2101-09.ap.freescale.net>
References: <1327329667-25512-1-git-send-email-fabio.estevam@freescale.com>
 <20120126122805.GC3523@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5DxPnCz1nYaCOvBPSiqwEj=QgrqfmkN9DtJP7AACYMFuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/26/12, Shawn Guo <shawn.guo@linaro.org> wrote:

> Name it mxs_clkctrl_divider_timeout to be more precise?

I kept the original name because if I use the name you suggested I
would have to break several lines for keeping them within 80 columns.

As this functions is called within several macros, it would not be
very readable after breaking  the lines.


Regards,

Fabio Estevam
