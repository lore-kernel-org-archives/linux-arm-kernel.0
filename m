From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 3 Oct 2011 15:08:24 +0100
Subject: [PATCH 5/6] ASoC: samsung: wm8994 depends on mfd_wm8994
In-Reply-To: <11174515.ANsqIhx0NX@wuerfel>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<1869072.QQLATNzYYx@wuerfel> <20111003120741.GD23811@sirena.org.uk>
	<11174515.ANsqIhx0NX@wuerfel>
Message-ID: <20111003140824.GM3731@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2011 at 03:43:10PM +0200, Arnd Bergmann wrote:

> > You've not sent a seprate patch for that one yet...

> I wasn't sure any more which version you wanted. Is this this right one?

I was expecting something that selects the core.  I was also expecting
something that can be applied against -next which this patch can't be,
this doesn't feel like something we should be rushing into 3.1.
