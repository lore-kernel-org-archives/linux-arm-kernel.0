From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 May 2015 11:36:50 +0100
Subject: [PATCH 1/3] spi: orion: Fix maximum baud rates for Armada 370/XP
In-Reply-To: <1432633484-18758-2-git-send-email-gregory.clement@free-electrons.com>
References: <1432633484-18758-1-git-send-email-gregory.clement@free-electrons.com>
 <1432633484-18758-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150526103650.GM21577@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 26, 2015 at 11:44:42AM +0200, Gregory CLEMENT wrote:

> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Reported-by: Kostya Porotchkin <kostap@marvell.com>
> Cc: <stable@vger.kernel.org> #Fixes df59fa7f4bca

Applied, but please format this stuff in a standard fashion - use a
Fixes: tag to reference commits you're fixing.  This makes it easier for
tooling to work with the information you're providing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150526/b17e768b/attachment.sig>
