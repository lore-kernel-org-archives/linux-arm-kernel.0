From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 9 Oct 2009 12:07:47 +0100
Subject: [PATCH] sound: at91sam9g20ek_2mmc board uses same audio
	connexion as at91sam9g20ek
In-Reply-To: <1255018789-3437-1-git-send-email-nicolas.ferre@atmel.com>
References: <1255018789-3437-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20091009110747.GA7104@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 08, 2009 at 06:19:49PM +0200, Nicolas Ferre wrote:
> The modified revision of at91sam9g20 Evaluation Kit rev. C and onwards share
> with previous ones its audio connexion to Wolfson wm8731. Modify the SoC file
> to extend the machine ID checking.

> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Applied, thanks.
