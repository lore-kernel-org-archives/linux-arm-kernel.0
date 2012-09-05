From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 5 Sep 2012 11:22:08 -0300
Subject: [PATCH 0/7] Add support for Freescale's mc34708 to mc13xxx driver
In-Reply-To: <11987916.rOoNGcb1ly@dev1>
References: <1342087073-3892-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <11987916.rOoNGcb1ly@dev1>
Message-ID: <CAOMZO5AVP1L-6A7cmV-kQEfG1C+vczFKT=sQbFtLJDaGau0kRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Samuel,

On Thu, Jul 12, 2012 at 8:02 PM, Marc Reilly <marc@cpdesign.com.au> wrote:
> Hi Uwe,
>
>> This series was tested on a Phytec pcm038 (mc13783 on spi) using
>> traditional boot (i.e. not dt) and on a i.MX53 based machine (mc34708 on
>> i2c) using dt boot.
>>
>> Philippe's patches are already in next, they are just included here for
>> those who want to test the patches. The 'mfd/mc13xxx: drop modifying
>> driver's id_table in probe' was already sent out yesterday and is
>> included here because the last patch depends on it.
>>
>
> For all patches (that don't already have it):
> Acked-by: Marc Reilly <marc@cpdesign.com.au>

Can this series be applied?

Regards,

Fabio Estevam
