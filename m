From: marex@denx.de (Marek Vasut)
Date: Fri, 15 Jun 2012 18:16:55 +0200
Subject: [PATCH v3 2/2] serial: mxs-auart: Allow device tree probing
In-Reply-To: <CAOMZO5BB5G5gvbcqDa2uB3hR-_o7XpcgXR9Ha+Xd7ZLpCqaOVw@mail.gmail.com>
References: <1339774557-23588-1-git-send-email-fabio.estevam@freescale.com>
 <20120615160635.GP31565@S2101-09.ap.freescale.net>
 <CAOMZO5BB5G5gvbcqDa2uB3hR-_o7XpcgXR9Ha+Xd7ZLpCqaOVw@mail.gmail.com>
Message-ID: <201206151816.55567.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> On Fri, Jun 15, 2012 at 1:06 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> >> +MODULE_DEVICE_TABLE(platform, mxs_auart_devtype);
> > 
> > ...
> > 
> >> +             .id_table = mxs_auart_devtype,
> > 
> > I do not think we need these.
> 
> WIthout this, the non-dt kernel does not probe correctly.

But we don't support non-DT kernel anymore.

Best regards,
Marek Vasut
