From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 Dec 2013 12:07:14 +0000
Subject: [PATCH] regulator: act8865: fix incorrect devm_kzalloc for act8865
In-Reply-To: <1388040763-15653-1-git-send-email-wenyou.yang@atmel.com>
References: <1388040763-15653-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20131230120714.GP31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 26, 2013 at 02:52:43PM +0800, Wenyou Yang wrote:
> Which cause to allocate more needless memory.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131230/2a3840f8/attachment.sig>
