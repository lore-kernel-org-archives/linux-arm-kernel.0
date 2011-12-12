From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 12 Dec 2011 12:29:50 +0800
Subject: [PATCH 07/10] ASoC: OMAP: ams-delta: Drive modem/codec pins over
 GPIO API
In-Reply-To: <1323634328-856-8-git-send-email-jkrzyszt@tis.icnet.pl>
References: <1323634328-856-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <1323634328-856-8-git-send-email-jkrzyszt@tis.icnet.pl>
Message-ID: <20111212042949.GA2806@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 11, 2011 at 09:12:05PM +0100, Janusz Krzysztofik wrote:
> Don't use Amstrad Delta custom I/O functions any longer, replace them
> with GPIO. Old pin definitions, no longer used by the modem bits either,
> can be dropped.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
