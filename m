From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 23 Jul 2015 10:58:37 +0200
Subject: [PATCH v2] ARM: dts: i.MX35: Fix can support.
In-Reply-To: <1437640272-5054-1-git-send-email-denis@eukrea.com>
References: <20150722180434.GA745@pengutronix.de>
 <1437640272-5054-1-git-send-email-denis@eukrea.com>
Message-ID: <55B0ACBD.6030903@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis,

[ add Marc to CC ]

Am 23.07.2015 um 10:31 schrieb Denis Carikli:
> Since commit 3d42a379b6fa5b46058e3302b1802b29f64865bb
> ("can: flexcan: add 2nd clock to support imx53 and newer")
> the can driver requires a dt nodes to have a second clock.
> Add them to imx35 to fix probing the flex can driver on the
> respective platforms.

could you describe the problem more in detail or do you have a log in
case the probing failed?

According to Marc's commit this fix shouldn't be necessary.

Regards
Stefan
