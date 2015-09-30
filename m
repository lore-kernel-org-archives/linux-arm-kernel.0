From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Sep 2015 10:24:56 +0200
Subject: [PATCH] arm64: dts: add all hi6220 uart nodes
In-Reply-To: <1443558552-5734-1-git-send-email-tyler.baker@linaro.org>
References: <1443558552-5734-1-git-send-email-tyler.baker@linaro.org>
Message-ID: <1459065.BtzC7pyUYF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 September 2015 13:29:12 Tyler Baker wrote:
>         aliases {
>                 serial0 = &uart0;
> +               serial1 = &uart1;
> +               serial2 = &uart2;
> +               serial3 = &uart3;
> +               serial4 = &uart4;
>         };
> 

In the changelog you mention "both uarts", but here you have five of them.
Are they all accessible on the connector? If not, only provide aliases
for the ones that are, using numbering that makes most sense for given
how one would use the board.

	Arnd
