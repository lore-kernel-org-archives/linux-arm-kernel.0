From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 23 Feb 2015 08:17:28 +0100
Subject: [PATCH v3 1/1] i.MX6: WEIM: improve error handling upon child
 probe-failure
In-Reply-To: <1424330650-8499-1-git-send-email-alison_chaiken@mentor.com>
References: <21911320.10lVZQzK19@jclayton-pc>
 <1424330650-8499-1-git-send-email-alison_chaiken@mentor.com>
Message-ID: <20150223071728.GH12209@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 18, 2015 at 11:24:10PM -0800, alison at she-devel.com wrote:
> From: Alison Chaiken <alison_chaiken@mentor.com>
> 
> Probe all children of the WEIM node, reporting any failures.  Report
> failure from parsing of WEIM node itself if probes of all children fail.
> 
> Signed-off-by: Alison Chaiken <alison_chaiken@mentor.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
