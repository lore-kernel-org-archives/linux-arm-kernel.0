From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Jul 2014 20:35:09 +0100
Subject: [PATCH v2 03/12] ASoC: kirkwood: Remove unused drivers
In-Reply-To: <1405028192-9623-4-git-send-email-andrew@lunn.ch>
References: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
 <1405028192-9623-4-git-send-email-andrew@lunn.ch>
Message-ID: <20140729193509.GK17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 11:36:23PM +0200, Andrew Lunn wrote:
> Both kirkwood-openrd and kirkwood-t5325 drivers have been replaced
> with DT based simple-card equivelents. So remove these drivers.

Applied.  Please send patches against current code, I needed to hand
apply this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140729/926fc82c/attachment-0001.sig>
