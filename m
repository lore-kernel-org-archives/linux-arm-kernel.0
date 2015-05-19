From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 19 May 2015 13:04:53 +0200
Subject: [PATCH v4 3/7] mmc: mediatek: Add PM support for MMC driver
In-Reply-To: <1432017411-2996-4-git-send-email-chaotian.jing@mediatek.com>
References: <1432017411-2996-1-git-send-email-chaotian.jing@mediatek.com>
 <1432017411-2996-4-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <20150519110453.GD26575@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chaotian,

On Tue, May 19, 2015 at 02:36:47PM +0800, Chaotian Jing wrote:
> Add PM support for Mediatek MMC driver
> Save/restore registers when PM

Has anyone asked you to add a new driver in two steps? I find it hard to
review if a driver is introduced and changed right afterwards.
Presumably you find it hard to maintain the patches like this also.
Please ignore if this is indeed requested by someone.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
