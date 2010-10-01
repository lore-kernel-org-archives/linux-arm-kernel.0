From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 1 Oct 2010 09:46:55 +0530
Subject: [PATCH 1/2] MTD: generic FSMC NAND MTD driver
In-Reply-To: <1284330922-3569-1-git-send-email-linus.walleij@stericsson.com>
References: <1284330922-3569-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4CA560B7.5080505@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2010 04:05 AM, Linus WALLEIJ wrote:
> This is the same driver submitted by ST Micros SPEAr team but
> generalized and tested on the ST-Ericsson U300. It probably
> easily works on the NHK8815 too.
> 
<snip...>
> ---
>  drivers/mtd/nand/Kconfig     |    7 +
>  drivers/mtd/nand/Makefile    |    1 +
>  drivers/mtd/nand/fsmc_nand.c |  862 ++++++++++++++++++++++++++++++++++++++++++
>  include/mtd/fsmc.h           |  181 +++++++++

Linus,

Just one query, what should be the location of fsmc.h
include/mtd/ or include/linux/mtd ??

viresh.
