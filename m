From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed, 27 Dec 2017 11:30:23 -0800
Subject: [PATCH 1/2] ARM: dts: imx6: RDU2: disable internal watchdog
In-Reply-To: <CAOMZO5AGrJ0f64mLQyjpbiZWusT+J6Q39Rc6+aN-hxX8Xe=R8A@mail.gmail.com>
References: <20171227035656.4941-1-andrew.smirnov@gmail.com>
 <CAOMZO5AGrJ0f64mLQyjpbiZWusT+J6Q39Rc6+aN-hxX8Xe=R8A@mail.gmail.com>
Message-ID: <CAHQ1cqGy3hZRy8RA-sHkT9-F7gZcncAc1KDGm7Y60iLKvrAKdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 27, 2017 at 3:09 AM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Andrey,
>
> On Wed, Dec 27, 2017 at 1:56 AM, Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
>> The system has an external watchdog in the environment processor
>> so the internal watchdog is of no use.
>>
>> Cc: Sascha Hauer <kernel@pengutronix.de>
>> Cc: Fabio Estevam <fabio.estevam@nxp.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: devicetree at vger.kernel.org
>> Cc: linux-kernel at vger.kernel.org
>> Cc: cphealy at gmail.com
>> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>
> Patch looks good.
>
> Just not clear if the authorship comes from you or Lucas.
>
> If Lucas is the original author then his name should appear in the From field.

Lucas is the original author and I am just a messenger. Sorry for the
confusion, will send a v2 with "From" fixed.

Sorry for the noise.

Thanks,
Andrey Smirnov
