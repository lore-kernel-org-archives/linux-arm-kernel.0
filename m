From: broonie@kernel.org (Mark Brown)
Date: Mon, 21 May 2018 11:05:03 +0100
Subject: [PATCH 3/6] ASoC: ams_delta: use GPIO lookup table
In-Reply-To: <20180518210954.29044-3-jmkrzyszt@gmail.com>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
 <20180518210954.29044-3-jmkrzyszt@gmail.com>
Message-ID: <20180521100503.GA24638@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2018 at 11:09:51PM +0200, Janusz Krzysztofik wrote:
> Now as the Amstrad Delta board provides GPIO lookup tables, switch from
> GPIO numbers to GPIO descriptors and use the table to locate required
> GPIO pins.

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180521/1da3f49e/attachment.sig>
