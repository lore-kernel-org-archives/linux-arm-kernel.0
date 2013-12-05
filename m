From: b32955@freescale.com (Huang Shijie)
Date: Thu, 5 Dec 2013 10:42:36 +0800
Subject: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <201312041636.20875.marex@denx.de>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA51905@DBDE04.ent.ti.com>
 <529EE5F1.9080806@st.com> <201312041636.20875.marex@denx.de>
Message-ID: <529FE81C.4000608@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?12?04? 23:36, Marek Vasut ??:
> I disagree we should bloat the API with features, that will be used by "possible
> future controllers" or "possible single controller", right from the start. The
> real question here is, can the API be designed in such a way, that the SR
> polling will happen in software NOW and only when a controller appears that can
> do polling in HW will the API be extended to support it ?
ok. Let's add this feature in the future when a real case occurs.

thanks
Huang Shijie
