From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 24 Jan 2012 13:00:08 +0000
Subject: [PATCH v4 - resend 10/13] ASoC: omap-abe-twl6040: Configure card
 according to platform data
In-Reply-To: <1327405950-6676-11-git-send-email-peter.ujfalusi@ti.com>
References: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
 <1327405950-6676-11-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120124130008.GC31839@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2012 at 01:52:27PM +0200, Peter Ujfalusi wrote:
> Disable the not connected pins on the board based on the
> received platform data.
> DO not register the jack function on boards, which does not have
> means to detect it (jack is always connected).

This should no longer be needed with the auto not connected stuff.
