From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 7 Mar 2013 10:24:17 +0100
Subject: [PATCH 2/3] arm: kirkwood: factor pinmux descriptors for
 OpenBlocks A6
In-Reply-To: <20130307090813.231548e6@skate>
References: <1362587021-32762-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1362587021-32762-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306181648.GE3904@lunn.ch> <20130306201646.179fce69@skate>
 <20130307062255.GH3904@lunn.ch> <20130307090813.231548e6@skate>
Message-ID: <20130307092417.GN30638@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> So I keep the GPIO muxing for the external GPIOs and the DIP switch
> GPIOs, but the one that are "claimed" by another device (like gpio-leds
> or gpio-keys), I should remove the muxing? I'm fine with that, just
> want to confirm the choice.

Hi Thomas,

Yes, i'm happy with that.

     Andrew
