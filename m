From: gerg@uclinux.org (Greg Ungerer)
Date: Sun, 28 Sep 2014 23:19:00 +1000
Subject: [PATCH] ARM: mvebu: use improved armada spi device tree compatible
 name
In-Reply-To: <20140928114353.GY27755@sirena.org.uk>
References: <1410147029-30067-1-git-send-email-gerg@uclinux.org>
 <20140909160043.GP30828@titan.lakedaemon.net>
 <20140928114353.GY27755@sirena.org.uk>
Message-ID: <54280AC4.8010809@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 28/09/14 21:43, Mark Brown wrote:
> On Tue, Sep 09, 2014 at 12:00:43PM -0400, Jason Cooper wrote:
>> On Mon, Sep 08, 2014 at 01:30:29PM +1000, gerg at uclinux.org wrote:
>>> Switch the Armada SoC SPI port device tree binding to use the new improved
>>> armada-370-spi compatible name. This allows for a wider range of baud rates
>>> to be used.
>> Applied to mvebu/dt.
> Note that the corresponding driver change hasn't been applied (or sent
> to me for review) so this will break users.

It still maintains the compatible "marvell,orion-spi" as well, so its
shouldn't break anyone with only that applied.

I will resend the spi-orion.c change.

Regards
Greg
