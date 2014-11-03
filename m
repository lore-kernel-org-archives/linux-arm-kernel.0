From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 3 Nov 2014 00:23:38 -0200
Subject: [Regression Resend] mmc: mx28: sd card detection broken since
 3.18-rc1
In-Reply-To: <5456B7B3.60401@gmail.com>
References: <1747777414.897866.1414878004147.JavaMail.open-xchange@oxbsltgw09.schlund.de>
 <5456B7B3.60401@gmail.com>
Message-ID: <CAOMZO5Cw7PGaum+HD7kPbgNqPdUE8U5E4wF61Kg7iu1nwjXxkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kristina,

On Sun, Nov 2, 2014 at 9:01 PM, Kristina Mart?enko
<kristina.martsenko@gmail.com> wrote:

> I ran into this issue as well. Seems that a card-detect flag
> (MMC_CAP2_CD_ACTIVE_HIGH) can currently be set based on an
> uninitialized variable, which can lead to the card being reported as
> not present. This patch fixes it for me:

Your patch fixes the card detection issue on mx28.

When you submit the patch formally, you can add my:

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks
