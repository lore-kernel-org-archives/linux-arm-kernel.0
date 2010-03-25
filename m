From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 25 Mar 2010 09:20:23 +0100
Subject: [PATCH] vic: factor out common init code
In-Reply-To: <0D753D10438DA54287A00B02708426976368AC7704@AUSP01VMBX24.collaborationhost.net>
References: <AcrG7twc5wXJWTzzQtezYQpL1OiKYw==>
	<0D753D10438DA54287A00B02708426976368AC7704@AUSP01VMBX24.collaborationhost.net>
Message-ID: <63386a3d1003250120m2d33233h60b202724a643a71@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/3/19 H Hartley Sweeten <hartleys@visionengravers.com>:

> This factors out the common initialization code for the two vic
> vendors into easier maintainable functions.

Sorry for the delay. Tested this on U300 and it works like a charm,
good patch.

Tested-by: Linus Walleij <linus.walleij@stericsson.com>

Linus Walleij
