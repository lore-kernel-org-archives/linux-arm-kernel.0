From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Jul 2014 20:35:58 +0100
Subject: [PATCH v2 04/12] ASoC: kirkwood: Remove ARCH_KIRKWOOD dependency
In-Reply-To: <1405028192-9623-5-git-send-email-andrew@lunn.ch>
References: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
 <1405028192-9623-5-git-send-email-andrew@lunn.ch>
Message-ID: <20140729193558.GL17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 11:36:24PM +0200, Andrew Lunn wrote:
> mach-kirkwood has been removed, now that kirkwood lives in
> mach-mvebu. Remove ARCH_KIRKWOOD since ARCH_MVEBU is sufficient.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140729/6d7e497c/attachment.sig>
