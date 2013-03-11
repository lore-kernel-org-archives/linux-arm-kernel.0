From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 11 Mar 2013 17:34:17 +0400
Subject: [PATCH] ARM: imx: fix typo "DEBUG_IMX50_IMX53_UART"
In-Reply-To: <1363007760.3137.69.camel@x61.thuisdomein>
References: <1363007760.3137.69.camel@x61.thuisdomein>
Message-ID: <513DDD59.6000903@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11-03-2013 17:16, Paul Bolle wrote:

> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> 0) Tested by grepping the tree.

> 1) Typo was added in commit f8c95fe6d9adad72fc7bce90f4ab68d119f50c5b
> ("ARM: imx: support DEBUG_LL uart port selection for all i.MX SoCs").
> Looking at that patch and at the tree makes clear that DEBUG_IMX53_UART
> was intended here.

    Should probably be in the changelog instead.

WBR, Sergei
