From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 6 Jan 2014 13:47:57 +0100
Subject: [PATCH 3/5] ARM: sun5i: a13: Add missing serial aliases
In-Reply-To: <1388945627-3432-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1388945627-3432-1-git-send-email-maxime.ripard@free-electrons.com>
 <1388945627-3432-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <201401061347.57955.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 05 January 2014, Maxime Ripard wrote:
> +       aliases {
> +               serial1 = &uart1;
> +               serial3 = &uart3;
> +       };
> +

If you only have two uarts active, shouldn't they be aliases
serial0 and serial1?

	Arnd
