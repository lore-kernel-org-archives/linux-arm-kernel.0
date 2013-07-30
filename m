From: davem@davemloft.net (David Miller)
Date: Tue, 30 Jul 2013 16:24:34 -0700 (PDT)
Subject: [PATCH v2] net: Add MOXA ART SoCs ethernet driver
In-Reply-To: <1374842890-20735-1-git-send-email-jonas.jensen@gmail.com>
References: <1374140806-12485-1-git-send-email-jonas.jensen@gmail.com>
 <1374842890-20735-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20130730.162434.539163047913568607.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Jensen <jonas.jensen@gmail.com>
Date: Fri, 26 Jul 2013 14:48:10 +0200

> +
> +CFLAGS_moxart_ether.o := -DDEBUG

This is not appropriate, please remove this.
