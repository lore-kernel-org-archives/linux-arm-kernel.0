From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 07 Mar 2011 11:49:31 +0200
Subject: [PATCH V5 1/6] pxa3xx_nand: make scan procedure more clear
In-Reply-To: <1299121710-6263-1-git-send-email-leiwen@marvell.com>
References: <AANLkTinb7oZDzvD94RWLZqnLnaX5kY97CxJ+34eVJNmU@mail.gmail.com>
	<1299121710-6263-1-git-send-email-leiwen@marvell.com>
Message-ID: <1299491371.2746.14.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-03-03 at 11:08 +0800, Lei Wen wrote:
> The previous probe function is some kind of big part.
> This patch seperate the resource allocation to keep the probe process
> more clear than before.
> 
> Signed-off-by: Lei Wen <leiwen@marvell.com>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

It is a bit confusing that you sent 2 patches 1 and 6. What is in the
middle? Is it save to apply these 2 only?

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
