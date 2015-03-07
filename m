From: horms@verge.net.au (Simon Horman)
Date: Sat, 7 Mar 2015 10:05:42 +0900
Subject: [PATCH] [RFC] ARM: shmobile: R-Car Gen2: Add da9063/da9210
 regulator quirk
In-Reply-To: <20150303094406.GI21293@sirena.org.uk>
References: <1425317323-5898-1-git-send-email-geert+renesas@glider.be>
 <20150303094406.GI21293@sirena.org.uk>
Message-ID: <20150307010542.GK19866@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 09:44:06AM +0000, Mark Brown wrote:
> On Mon, Mar 02, 2015 at 06:28:43PM +0100, Geert Uytterhoeven wrote:
> > The r8a7791/koelsch development board has da9063 and da9210 regulators.
> > Both regulators have their interrupt request lines tied to the same
> > interrupt pin (IRQ2) on the SoC.
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>
> 
> This is all rather fun isn't it?

Hi Geert,

please repost this with Mark's Ack as a non-RFC if you would like me
to pick it up.
