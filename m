From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 3 May 2011 09:12:59 +0200
Subject: [PATCH 05/10] clk: Add support for simple dividers
In-Reply-To: <4DBF7862.3050103@codeaurora.org>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-6-git-send-email-s.hauer@pengutronix.de>
	<20110418094909.GE31131@pengutronix.de>
	<20110418100716.GJ14770@pengutronix.de>
	<4DACF761.3050503@codeaurora.org>
	<20110428151447.GS17290@n2100.arm.linux.org.uk>
	<4DBF7862.3050103@codeaurora.org>
Message-ID: <20110503071259.GB11574@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, May 02, 2011 at 08:37:06PM -0700, Saravana Kannan wrote:
> I think a better way to solve this problem is to have a
> clk_set_rate_range() and hence suggesting it. This would also help
> reduce the no. of lines/data passed in board files which I think
> helps clean up ARM code.
Just an implementation detail: clk_round_rate_range would be enough.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
