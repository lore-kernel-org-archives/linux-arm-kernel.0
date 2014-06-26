From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 26 Jun 2014 20:10:12 +0200
Subject: [PATCH 0/7] Kirkwood ASoC updates
In-Reply-To: <20140626142231.GR32514@n2100.arm.linux.org.uk>
References: <20140626142231.GR32514@n2100.arm.linux.org.uk>
Message-ID: <20140626181012.GE18520@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 03:22:31PM +0100, Russell King - ARM Linux wrote:
> Mark,
> 
> Here are a set of patches I've had for a while as part of my DPCM work.
> I think it's worth getting these merged.

Hi Russell, Mark

I tested simple playback of WAV and MP3 files on a Kirkwood based HP
T5325 machine. No obvious regressions.

Tested-by: Andrew Lunn <andrew@lunn.ch>

> Patch 7 adds NO_PERIOD_WAKEUP support for kirkwood, permitting
> interrupt-less operation.

When using mpg123 to play back mp3 files, i get about 9 interrupts per
second for kirkwood-i2s. Does this sound right?

       Andrew
