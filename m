From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 25 Jun 2014 14:55:36 -0300
Subject: [PATCH v3 2/3] ARM: dts: i.MX25: Fix gpt timers clocks.
In-Reply-To: <1403700096-13014-2-git-send-email-denis@eukrea.com>
References: <1403700096-13014-1-git-send-email-denis@eukrea.com>
 <1403700096-13014-2-git-send-email-denis@eukrea.com>
Message-ID: <CAOMZO5BNQXCVYt1d9pML2xwrG1i=-t3c2sLbsV2VLYJvgMsEJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 9:41 AM, Denis Carikli <denis@eukrea.com> wrote:
> Without that fix, the board freeze during boot.
>
> This appeared after the following commit:
>   496f065 ARM: i.MX: Use of_clk_get_by_name() for timer clocks for DT case.
>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

This allows mx25pdk to boot again, thanks:

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
