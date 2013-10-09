From: broonie@kernel.org (Mark Brown)
Date: Wed, 9 Oct 2013 11:59:50 +0100
Subject: [PATCH 5/9] spi: spi-au1550: replace platform_driver_probe to
 support deferred probing
In-Reply-To: <1381264542-29396-6-git-send-email-wsa@the-dreams.de>
References: <1381264542-29396-1-git-send-email-wsa@the-dreams.de>
 <1381264542-29396-6-git-send-email-wsa@the-dreams.de>
Message-ID: <20131009105950.GI21581@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 10:35:37PM +0200, Wolfram Sang wrote:
> Subsystems like pinctrl and gpio rightfully make use of deferred probing at
> core level. Now, deferred drivers won't be retried if they don't have a .probe
> function specified in the driver struct. Fix this driver to have that, so the
> devices it supports won't get lost in a deferred probe.

Applied 5-9, thanks - if there's patches 1-4 you'll need to resend them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131009/3c0921b0/attachment.sig>
