From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 4 Apr 2018 09:02:15 +0200
Subject: [PATCH v3 5/6] spi: sun6i: introduce register set/unset helpers
In-Reply-To: <20180403154449.2443-6-ssuloev@orpaltech.com>
References: <20180403154449.2443-1-ssuloev@orpaltech.com>
 <20180403154449.2443-6-ssuloev@orpaltech.com>
Message-ID: <20180404070215.matr7snuyxjd7syu@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 03, 2018 at 06:44:48PM +0300, Sergey Suloev wrote:
> Two helper functions were added in order to set/unset
> specified flags in registers.
> 
> Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>

Again, I'm not really sure what the benefit of that is. Your diffstat
is pretty much identical, so it's basically just moving code around.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180404/e3e6cc12/attachment.sig>
