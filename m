From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 06 Mar 2014 17:31:40 +0100
Subject: [PATCH v9][ 3/8] staging: imx-drm: Correct BGR666 and the
 board's dts that use them.
In-Reply-To: <1394121702-13257-3-git-send-email-denis@eukrea.com>
References: <1394121702-13257-1-git-send-email-denis@eukrea.com>
 <1394121702-13257-3-git-send-email-denis@eukrea.com>
Message-ID: <1394123500.3622.56.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis,

Am Donnerstag, den 06.03.2014, 17:01 +0100 schrieb Denis Carikli:
> The current BGR666 is not consistent with the other color mapings like BGR24.
> BGR666 should be in the same byte order than BGR24.
>
> Signed-off-by: Denis Carikli <denis@eukrea.com>

patches 1 to 3
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

You should add Russell King to Cc:, who has volunteered to collect
imx-drm patches before sending them on to Greg for now.

regards
Philipp
