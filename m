From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 9 Sep 2016 16:17:10 +0200
Subject: [PATCH v3 3/9] ARM: sun8i: dt: Add DT bindings documentation for
 Allwinner sun8i-emac
In-Reply-To: <1473425117-18645-4-git-send-email-clabbe.montjoie@gmail.com>
References: <1473425117-18645-1-git-send-email-clabbe.montjoie@gmail.com>
 <1473425117-18645-4-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20160909141710.GF30871@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +Optional properties:
> +- allwinner,tx-delay: TX clock delay chain value. Range value is 0-0x07. Default is 0)
> +- allwinner,rx-delay: RX clock delay chain value. Range value is 0-0x1F. Default is 0)

What are the units? pS? nS?

     Andrew
