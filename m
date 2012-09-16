From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 16 Sep 2012 11:44:25 -0300
Subject: [PATCH V4] MXS: Implement DMA support into mxs-i2c
In-Reply-To: <20120916104436.GC933@pengutronix.de>
References: <1345779871-7677-1-git-send-email-marex@denx.de>
 <CAOMZO5CSvP3nXNq4VLYALh+U9OZRnjtgXqTr7zsKdeHpUdJ4cQ@mail.gmail.com>
 <20120916104436.GC933@pengutronix.de>
Message-ID: <CAOMZO5AFHHOH7qwEfuxKfKCNdc4jwPk3Z8m8PxLKrwSKs=4tKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Sun, Sep 16, 2012 at 7:44 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:

>> Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
>
> Thanks, may I ask what your tests were?

I used i2c-tools to read/write to an i2c at24 eeprom connected to my mx28evk.

Regards,

Fabio Estevam
