From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 13 Oct 2015 08:19:29 +0200
Subject: [PATCH 00/37] ARM: dts: Fix fixed regulators enable GPIO polarity
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <20151013061929.GX7858@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 12:12:29AM +0300, Laurent Pinchart wrote:
> Hello,
> 
> While working on regulators, GPIOs and DT I noticed that many of our DT source
> files incorrectly describe fixed regulators. The common error patterns are
> 
> - Usage of the undefined (and never parsed) enable-active-low property
> - Usage of the enable-active-high property without specifying an enable GPIO
> - Typos in the enabl GPIO property name (gpios instead of gpio)
> - Mismatch between the enable-active-high property (or the lack thereof) and
>   the enable GPIO flags
> 
> This patch series fixes those issues in all the DT sources after locating the
> errors using the following script.

Nice. For the i.MX boards:

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
