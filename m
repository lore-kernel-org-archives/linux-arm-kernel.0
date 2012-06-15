From: marex@denx.de (Marek Vasut)
Date: Fri, 15 Jun 2012 19:00:21 +0200
Subject: [PATCH v3 2/2] serial: mxs-auart: Allow device tree probing
In-Reply-To: <CAOMZO5AFaWGEfEhVs1TVc0c_Wp6aB7FT5zKHEoiucLnuWGg8zA@mail.gmail.com>
References: <1339774557-23588-1-git-send-email-fabio.estevam@freescale.com>
 <201206151816.55567.marex@denx.de>
 <CAOMZO5AFaWGEfEhVs1TVc0c_Wp6aB7FT5zKHEoiucLnuWGg8zA@mail.gmail.com>
Message-ID: <201206151900.21740.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> On Fri, Jun 15, 2012 at 1:16 PM, Marek Vasut <marex@denx.de> wrote:
> > Dear Fabio Estevam,
> > 
> >> On Fri, Jun 15, 2012 at 1:06 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> >> >> +MODULE_DEVICE_TABLE(platform, mxs_auart_devtype);
> >> > 
> >> > ...
> >> > 
> >> >> +             .id_table = mxs_auart_devtype,
> >> > 
> >> > I do not think we need these.
> >> 
> >> WIthout this, the non-dt kernel does not probe correctly.
> > 
> > But we don't support non-DT kernel anymore.
> 
> but I don't want my patch to break something that has been working for
> a long time.

But we don't care if the non-DT case gets broken anyway *. It's unsupported and 
will be removed.

* that's how I understand it.

Best regards,
Marek Vasut
