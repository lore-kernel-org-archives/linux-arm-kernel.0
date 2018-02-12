From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 12 Feb 2018 12:08:06 +0100 (CET)
Subject: [PATCH 1/1] mtd: ubi: Update ubi-media.h to dual license
In-Reply-To: <20180212105642.8662-2-lionel.debieve@st.com>
References: <20180212105642.8662-1-lionel.debieve@st.com>
 <20180212105642.8662-2-lionel.debieve@st.com>
Message-ID: <alpine.DEB.2.21.1802121206440.1158@nanos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Feb 2018, Lionel Debieve wrote:

> Update license template using SPDX. Move the global layout
> of UBI headers to dual license helping UBI to be the standard
> solution for raw NAND management.

No objections from my side, but you really need to poke IBM about that. And
if that happens then the kernel header. where this is copied from needs to
be updated as well....

Thanks,

	tglx
