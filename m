From: broonie@kernel.org (Mark Brown)
Date: Fri, 22 May 2015 12:18:08 +0100
Subject: [PATCH v5 01/11] regmap: Introduce regmap_get_max_register.
In-Reply-To: <1432226563-8689-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1432226535-8640-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1432226563-8689-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20150522111808.GC21391@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 05:42:43PM +0100, Srinivas Kandagatla wrote:
> This patch introduces regmap_get_max_register() function which would be
> used by the infrastructures like nvmem framework built on top of
> regmap.

Applied, thanks.  If the rest of the framework is ready to get merged
somewhere before it reaches Linus' tree let me know and we can handle it
then.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150522/728b57a9/attachment.sig>
