From: broonie@kernel.org (Mark Brown)
Date: Fri, 6 Sep 2013 10:31:11 +0100
Subject: [PATCH] ASoC: kirkwood: change the compatible string of the
 kirkwood-i2s driver
In-Reply-To: <1378385791-29551-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1378385791-29551-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130906093111.GA18774@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 05, 2013 at 02:56:31PM +0200, Thomas Petazzoni wrote:
> The compatible string of the kirkwood-i2s driver was chosen as
> "marvell,mvebu-audio". Using such a compatible string is not a good
> idea, since "mvebu" is the name of a large family of SOCs, in which
> new, unknown SOCs will be coming in the future. It is therefore

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130906/d2d8304f/attachment-0001.sig>
