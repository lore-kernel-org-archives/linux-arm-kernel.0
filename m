From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 31 Mar 2015 11:15:26 +0200
Subject: [PATCH RFC 06/11] drm: bridge/dw_hdmi: introduce interfaces to
 enable and disable audio
In-Reply-To: <E1YcfXu-0002v9-SB@rmk-PC.arm.linux.org.uk>
References: <20150330193911.GM24899@n2100.arm.linux.org.uk>
 <E1YcfXu-0002v9-SB@rmk-PC.arm.linux.org.uk>
Message-ID: <1427793326.2969.22.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Am Montag, den 30.03.2015, 20:40 +0100 schrieb Russell King:
> iMX6 devices from an errata (ERR005174) where the audio FIFO can be
              ^ suffer from?

> emptied while it is partially full, resulting in misalignment of the
> audio samples.
[...]

regards
Philipp
