From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 9 Sep 2012 15:11:54 -0400
Subject: [PATCH 1/2] ARM: Kirkwood: ehci-orion: Add device tree binding
In-Reply-To: <1346491586-23480-1-git-send-email-andrew@lunn.ch>
References: <1346491586-23480-1-git-send-email-andrew@lunn.ch>
Message-ID: <20120909191154.GB4575@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 01, 2012 at 11:26:25AM +0200, Andrew Lunn wrote:
> Based on previous work by Michael Walle and Jason Cooper.
> 
> Made their work actually work, which required added interrupt from DT
> and auxdata, along with setting the dma_mask, which DT does not
> currently do.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Applied to:

git://git.infradead.org/users/jcooper/linux.git kirkwood/dt

thx,

Jason.
