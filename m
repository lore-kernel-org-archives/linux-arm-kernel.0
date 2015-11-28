From: mw@semihalf.com (Marcin Wojtas)
Date: Sat, 28 Nov 2015 17:43:57 +0100
Subject: [PATCH net-next 3/3] net: mvneta: Add naive RSS support
In-Reply-To: <1448463243-21057-4-git-send-email-gregory.clement@free-electrons.com>
References: <1448463243-21057-1-git-send-email-gregory.clement@free-electrons.com>
 <1448463243-21057-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <CAPv3WKfEJGAHgDvfyeHKZaiJqbsyrV+uKM+E3enbNLVznLY6zA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

> +
> +       /* update unicast mapping */
> +       mvneta_set_rx_mode(pp->dev);

I know it may be an ultimate level of nitpicking, but can you start a
comment with capital letter?:)

Best regards,
Marcin
