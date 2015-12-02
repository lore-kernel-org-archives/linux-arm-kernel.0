From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Dec 2015 20:39:16 +0100
Subject: [PATCH v2 3/7] clk: Amlogic: Add reset controller for CPU cores
 for Meson8b
In-Reply-To: <1449076953-5058-4-git-send-email-carlo@caione.org>
References: <1449076953-5058-1-git-send-email-carlo@caione.org>
 <1449076953-5058-4-git-send-email-carlo@caione.org>
Message-ID: <1589870.aoo3TedUT8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 December 2015 18:22:29 Carlo Caione wrote:
>  
> +#define RST_CORE0              0
> +#define RST_CORE1              1
> +#define RST_CORE2              2
> +#define RST_CORE3              3

These defines are rather silly and just cause interdependencies with the header
file. Just drop them and use the numbers directly.

	Arnd
