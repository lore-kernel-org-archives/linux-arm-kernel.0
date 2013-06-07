From: broonie@kernel.org (Mark Brown)
Date: Fri, 7 Jun 2013 17:55:10 +0100
Subject: [RFC PATCH 28/50] ASoC: atmel-ssc: prepare clk before calling
 enable
In-Reply-To: <1370622370-19614-1-git-send-email-b.brezillon@overkiz.com>
References: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
 <1370622370-19614-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <20130607165510.GA31367@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 06:26:09PM +0200, Boris BREZILLON wrote:
> Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
> avoid common clk framework warnings.

Applied since I happened to notice this on he list but you should
*always* CC maintainers on patches otherwise they're likely to get
missed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130607/5e116406/attachment-0001.sig>
