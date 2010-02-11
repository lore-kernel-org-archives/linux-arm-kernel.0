From: Steve.Glendinning@smsc.com (Steve.Glendinning at smsc.com)
Date: Thu, 11 Feb 2010 18:26:32 +0000
Subject: smsc911x suspend/resume
In-Reply-To: <20100208144951.GF28972@buzzloop.caiaq.de>
Message-ID: <OFB9598254.A94CFB16-ON802576C5.004BB8B6-802576C7.00655296@smsc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hmm, be careful about switching off power supplies that aren't supposed
> to be switched off while others are still powered. You can easily
> destroy hardware with that. Depending on how things are wired up
> internally, voltages can leak from one unit block to the other. Maybe
> Steve can can give a statement from official SMSC source about whether
> it is safe to switch off VDD33A in this case.

I've checked with the chip architects, no power planes should be 
externally
switched off in any suspend mode.

Steve
