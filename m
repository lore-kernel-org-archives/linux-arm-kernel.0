From: broonie@kernel.org (Mark Brown)
Date: Mon, 22 Dec 2014 12:02:53 +0000
Subject: [PATCH 27/28] ASoC: samsung: drop owner assignment from
 platform_drivers
In-Reply-To: <1419196495-9626-28-git-send-email-wsa@the-dreams.de>
References: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
 <1419196495-9626-28-git-send-email-wsa@the-dreams.de>
Message-ID: <20141222120253.GG17800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 21, 2014 at 10:14:48PM +0100, Wolfram Sang wrote:
> This platform_driver does not need to set an owner, it will be populated by the
> driver core.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141222/82645b22/attachment-0001.sig>
