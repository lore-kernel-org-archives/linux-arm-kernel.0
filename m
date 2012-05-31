From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 31 May 2012 20:51:00 -0300
Subject: [PATCH 1/2] MFD: Fix mc13xxx SPI regmap
In-Reply-To: <1338282389-26177-2-git-send-email-philippe.retornaz@epfl.ch>
References: <1338282389-26177-1-git-send-email-philippe.retornaz@epfl.ch>
 <1338282389-26177-2-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <CAOMZO5C9B-xUzo+OQ1HWPqc5pdiGreE3oArC+FM=8q+FB9K1ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,

On Tue, May 29, 2012 at 6:06 AM, Philippe R?tornaz
<philippe.retornaz@epfl.ch> wrote:
> This fix the SPI regmap configuration, the wrong write flag was used.
> Also, bits_per_word should not be set as the regmap spi implementation
> uses a 8bits transfert granularity.
>
> Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>

Excellent!

I tested your patch series on a mx51evk, mx27pdk and mx31pdk:

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks,

Fabio Estevam
