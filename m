From: broonie@kernel.org (Mark Brown)
Date: Fri, 22 May 2015 12:19:05 +0100
Subject: [PATCH v5 02/11] regmap: Introduce regmap_get_reg_stride.
In-Reply-To: <1432226574-8733-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1432226535-8640-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1432226574-8733-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20150522111905.GD21391@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 05:42:54PM +0100, Srinivas Kandagatla wrote:
> This patch introduces regmap_get_reg_stride() function which would
> be used by the infrastructures like nvmem framework built on top of
> regmap. Mostly this function would be used for sanity checks on inputs
> within such infrastructure.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150522/c4cf711a/attachment.sig>
