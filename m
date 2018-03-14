From: broonie@kernel.org (Mark Brown)
Date: Wed, 14 Mar 2018 09:26:09 -0700
Subject: [PATCH] ASoC: uniphier: evea: add switch for changing source of
 line-in
In-Reply-To: <20180314123900.19505-1-suzuki.katsuhiro@socionext.com>
References: <20180314123900.19505-1-suzuki.katsuhiro@socionext.com>
Message-ID: <20180314162609.GV2186@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2018 at 09:39:00PM +0900, Katsuhiro Suzuki wrote:
> This patch adds mixer switch for changing audio source of line-in.
> We can choose one of LIN1, 2, 3, default is LIN1.

I'll apply for now but this should really be a DAPM control so that we
can power down things connected to the disconnected line inputs when
recording.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180314/81ff8062/attachment.sig>
