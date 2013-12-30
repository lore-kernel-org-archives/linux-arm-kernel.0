From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 Dec 2013 12:03:27 +0000
Subject: [PATCH] regulator: act8865: register all regulators regardless
 of how many are used
In-Reply-To: <1388023041-25785-1-git-send-email-wenyou.yang@atmel.com>
References: <1388023041-25785-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20131230120327.GN31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 26, 2013 at 09:57:21AM +0800, Wenyou Yang wrote:
> As Mark pointed out, the driver should register all regulators
> regardless of how many are used in the system in order to aid diagnostics.

Thanks for doing this but it doesn't apply against the current code due
to the fixups from Axel.  Can you please check and resend?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131230/5f41608a/attachment.sig>
