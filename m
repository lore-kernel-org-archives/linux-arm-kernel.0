From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 4 Oct 2012 18:50:26 +0100
Subject: [RESEND][PATCH] ASoC: ams-delta: Convert to use
 snd_soc_register_card()
In-Reply-To: <1582731.dIkBtAuyKn@vclass>
References: <20120906073633.GC22330@opensource.wolfsonmicro.com>
 <1582731.dIkBtAuyKn@vclass>
Message-ID: <20121004175025.GU4360@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 03, 2012 at 12:46:57PM +0200, Janusz Krzysztofik wrote:
> The old method of registering with the ASoC core by creating a
> "soc-audio" platform device no longer works for Amstrad Delta sound card
> after recent changes to drvdata handling (commit
> 0998d0631001288a5974afc0b2a5f568bcdecb4d, 'device-core: Ensure drvdata =
> NULL when no driver is bound'.

Applied, thanks.
