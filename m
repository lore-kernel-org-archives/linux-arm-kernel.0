From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 2 Oct 2011 22:29:59 +0100
Subject: [PATCH 5/6] ASoC: samsung: fix Kconfig dependencies
In-Reply-To: <3289863.m6ULFZUV3p@wuerfel>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<1317587284-2776-6-git-send-email-arnd@arndb.de>
	<20111002204729.GC5811@opensource.wolfsonmicro.com>
	<3289863.m6ULFZUV3p@wuerfel>
Message-ID: <20111002212958.GD4506@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 02, 2011 at 11:14:55PM +0200, Arnd Bergmann wrote:

> So should SND_SOC_WM8994 instead select MFD_WM8994? That would mean adding
> the select only in one place.

select ignores the dependencies of the things it selects which isn't
enormously helpful for this sort of stuff.
