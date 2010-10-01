From: dwmw2@infradead.org (David Woodhouse)
Date: Fri, 01 Oct 2010 14:21:29 +0900
Subject: [PATCH 1/2] MTD: generic FSMC NAND MTD driver
In-Reply-To: <4CA560B7.5080505@st.com>
References: <1284330922-3569-1-git-send-email-linus.walleij@stericsson.com>
	<4CA560B7.5080505@st.com>
Message-ID: <1285910489.31224.14.camel@macbook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-10-01 at 09:46 +0530, viresh kumar wrote:
> 
> 
> Just one query, what should be the location of fsmc.h
> include/mtd/ or include/linux/mtd ?? 

We use include/mtd/ for headers which are exported to userspace. Looks
like this should be include/linux/mtd/

-- 
dwmw2
