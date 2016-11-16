From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 16 Nov 2016 16:43:41 -0200
Subject: Boot failures in -next due to 'ARM: dts: imx: Remove
 skeleton.dtsi'
In-Reply-To: <cda2df55-f2f3-00d6-c6b1-816ed47bbf56@roeck-us.net>
References: <cda2df55-f2f3-00d6-c6b1-816ed47bbf56@roeck-us.net>
Message-ID: <CAOMZO5BqEsojFpzwtO74hrmH6nh7CRckwmasDYOV0GBdk4bqMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

On Wed, Nov 16, 2016 at 3:45 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> Hi,
>
> my 'sabrelite' and 'imx25-pdk' qemu boot tests are failing in linux-next.
>
> Bisect for the sabrelite failure points to commit 'ARM: dts: imx: Remove
> skeleton.dtsi'.

Interesting. I am not able to reproduce the boot failure and also do
not see it reported at kernelci.org:

https://kernelci.org/soc/imx/job/next/kernel/next-20161115/

nor at Olof's autobooter:
http://arm-soc.lixom.net/bootlogs/next/next-20161116/wandboard-arm-multi_v7_defconfig.html

Not sure why the boot fails with qemu. I will try to install qemu here
and take a look.

Regards,

Fabio Estevam
