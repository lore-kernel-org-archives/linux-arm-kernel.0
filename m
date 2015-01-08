From: broonie@kernel.org (Mark Brown)
Date: Thu, 8 Jan 2015 20:16:36 +0000
Subject: [PATCH v5 0/5] regulator: Allow parsing custom DT properties
 with simplified DT parse
In-Reply-To: <1420458525-22576-1-git-send-email-k.kozlowski@samsung.com>
References: <1420458525-22576-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20150108201636.GE2634@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 05, 2015 at 12:48:40PM +0100, Krzysztof Kozlowski wrote:
> Hi,
> 
> 
> The patchset adds:
> 1. a way of parsing custom DT properties by the driver when simplified
>    DT parsing method is used,
> 2. GPIO enable control to the max77686 driver.

Applied 1-4, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150108/ed295216/attachment.sig>
