From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Tue, 18 Feb 2014 11:56:35 -0300
Subject: [PATCH v2 1/2] clk: sunxi: Add new clock compatibles
In-Reply-To: <1391676958-13883-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1391676958-13883-1-git-send-email-maxime.ripard@free-electrons.com>
 <1391676958-13883-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <530374A3.3010104@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

El 06/02/14 05:55, Maxime Ripard escribi?:
> The Allwinner A10 compatibles were following a slightly different compatible
> patterns than the rest of the SoCs for historical reasons. Add compatibles
> matching the other pattern to the clock driver for consistency, and keep the
> older one for backward compatibility.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

I have taken this patch on sunxi-clk-for-mike. Please note that there 
were some conflicts which I had to fix, so I'd appreciate it if you 
could check I didn't miss anything.

Thanks!

Emilio
