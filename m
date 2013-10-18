From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 18 Oct 2013 09:59:33 +0200
Subject: Devicetree support for Eukrea cpuimx{25,35,51} (v2)
In-Reply-To: <1382022155-21954-1-git-send-email-denis@eukrea.com>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
Message-ID: <20131018075933.GV30088@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis,

On Thu, Oct 17, 2013 at 05:01:58PM +0200, Denis Carikli wrote:
> Hi,
> 
> Here is a new version of the patch serie that was meant to
>   add support for the Eukrea cpuimx{25,35,51} and their
>   respective baseboards.

This series contains some nice stuff, but it touches too many
subsystems which makes it hard to apply. I suggest that you split it up
by subsystems. Also it probably makes sense to drop graphics support
for the i.MX35 board dts for now as it probably takes some time to get
the binding straight.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
