From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Jan 2010 08:52:54 +0000
Subject: [PATCH] arm: add a comment to __atags_pointer describing where
	it's set
In-Reply-To: <1263890623-14952-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100119083803.GA17904@pengutronix.de>
	<1263890623-14952-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100119085253.GA24447@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2010 at 09:43:42AM +0100, Uwe Kleine-K?nig wrote:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Grep is a wonderful tool for this; we have many more like this and
it really doesn't make sense to start adding comments describing
where things get written.
