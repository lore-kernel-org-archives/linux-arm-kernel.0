From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 7 Mar 2013 07:22:55 +0100
Subject: [PATCH 2/3] arm: kirkwood: factor pinmux descriptors for
 OpenBlocks A6
In-Reply-To: <20130306201646.179fce69@skate>
References: <1362587021-32762-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1362587021-32762-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306181648.GE3904@lunn.ch> <20130306201646.179fce69@skate>
Message-ID: <20130307062255.GH3904@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 08:16:46PM +0100, Thomas Petazzoni wrote:
> Dear Andrew Lunn,
> 
> On Wed, 6 Mar 2013 19:16:48 +0100, Andrew Lunn wrote:
> 
> > There is no need to pinmux gpio pins at all. The pinctrl driver does
> > it when the gpio driver requests the pins.
> 
> Right, that's true. I knew about this, but since the pinmux
> configuration was made explicit for those GPIOs, I thought the original
> author(s) of this .dts did this intentionally. For example, it somewhat
> documents the 8 GPIOs that are available in the bottom connector of the
> OpenBlocks A6. They are not tied to anyway particular device, so they
> wouldn't appear anywhere in the DT. Ditto for the DIP switch GPIOs. Do
> you also want those to be removed from the DT?

Hi Thomas

Good point. They are not required, but don't harm. So yes, leave them
there for documentation purposes.

      Andrew
