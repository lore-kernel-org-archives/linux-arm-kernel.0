From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 5 Jan 2010 11:08:59 +0000
Subject: [PATCH 3/3] mx31ads: Provide an IRQ range to the WM835x on the
	1133-EV1 module
In-Reply-To: <1262629491-18942-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1262629491-18942-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1262629491-18942-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20100105110859.GA5189@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2010 at 06:24:51PM +0000, Mark Brown wrote:
> The WM8350 core won't actually use the range yet, but it will in
> future and the platform data to configure it is there now.

> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Please don't apply this one, there's already an IRQ expander on the
board.  I'll send a revised patch later.
