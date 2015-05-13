From: broonie@kernel.org (Mark Brown)
Date: Wed, 13 May 2015 12:06:05 +0100
Subject: [PATCH] regulator: of: Skip disabled regulator nodes
In-Reply-To: <1431466927-1329-1-git-send-email-sboyd@codeaurora.org>
References: <1431466927-1329-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150513110605.GF3066@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 02:42:07PM -0700, Stephen Boyd wrote:
> If a regulator is listed in devicetree, but the node is marked as
> "disabled" we should skip parsing the regulator init data and
> deny consumers from interacting with the regulator. This

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150513/dfd5fe5e/attachment.sig>
