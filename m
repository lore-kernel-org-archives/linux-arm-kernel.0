From: olof@lixom.net (Olof Johansson)
Date: Mon, 11 Nov 2013 11:35:45 -0800
Subject: [PATCH v4 3/4] ARM: v7-M: drop using mach/entry-macro.S
In-Reply-To: <1383562853-17202-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20131104105836.GI14892@pengutronix.de>
 <1383562853-17202-3-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20131111193545.GB12278@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 04, 2013 at 12:00:52PM +0100, Uwe Kleine-K?nig wrote:
> The only v7-M platform only has some unused stubs in its
> mach/entry-macro.S file. So don't include it which allows efm32 to drop
> the file.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
