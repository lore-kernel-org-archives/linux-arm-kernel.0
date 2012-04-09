From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 9 Apr 2012 14:27:18 +0000
Subject: [PATCH 6/7] MMC: mmci: Enable Device Tree support for ux500
 variants
In-Reply-To: <20120406041401.28A993E0BC4@localhost>
References: <1333619748-16126-1-git-send-email-lee.jones@linaro.org>
 <4F7DA1DE.2030203@linaro.org> <20120406041401.28A993E0BC4@localhost>
Message-ID: <201204091427.19110.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 April 2012, Grant Likely wrote:
> Yes, "clock-frequency" already has established usage as an exact clock
> specification.  If it is a maximum as you say then something like
> "max-frequency" makes more sense.
> 
> Someone was working on a common MMC DT binding.  Really all of the MMC
> drivers should use the same binding for the common bits.

Agreed.

Should we use max-frequency or clock-frequency for sdhci though? It looks
like this is both the maximum frequency that it can use and the base frequency
that the actual clock rate is derived from (can be a fraction).

	Arnd
