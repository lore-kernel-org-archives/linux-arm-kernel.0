From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Fri, 1 Oct 2010 09:25:09 +0200
Subject: [PATCH 1/2] MTD: generic FSMC NAND MTD driver
In-Reply-To: <1285910489.31224.14.camel@macbook.infradead.org>
References: <1284330922-3569-1-git-send-email-linus.walleij@stericsson.com>
	<4CA560B7.5080505@st.com>
	<1285910489.31224.14.camel@macbook.infradead.org>
Message-ID: <AANLkTintC=5Mo82QS0xxB143WrHrijqGOqdyZ=2BxCYe@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/1 David Woodhouse <dwmw2@infradead.org>:
> On Fri, 2010-10-01 at 09:46 +0530, viresh kumar wrote:

>> Just one query, what should be the location of fsmc.h
>> include/mtd/ or include/linux/mtd ??
>
> We use include/mtd/ for headers which are exported to userspace. Looks
> like this should be include/linux/mtd/

Aha, I'll respin it then.

Yours,
Linus Walleij
