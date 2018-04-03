From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 3 Apr 2018 20:35:07 +0200
Subject: [PATCH v6 0/3] add support for Socionext SynQuacer I2C controller
In-Reply-To: <20180403183219.htbg3w6mejmysoel@ninjato>
References: <20180325110747.8852-1-ard.biesheuvel@linaro.org>
 <20180403150139.l7oec4doafmsidfp@ninjato>
 <CAKv+Gu9cqQqq_etTSvdBp4Jjk5O_0FePe74phDqt5EO6Cm-_vQ@mail.gmail.com>
 <20180403181216.f22vtkqrnxjgreuo@ninjato>
 <CAKv+Gu8R19T+9O2tODQeS9vtKANmBXgGcavkRdVRU0NmVtHn2w@mail.gmail.com>
 <20180403183219.htbg3w6mejmysoel@ninjato>
Message-ID: <CAKv+Gu_GTmCr8att-_iQ5rD64gvaQC2FJ3cAmYpqRqp_OqPcAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

x`On 3 April 2018 at 20:32, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> I have used it with a ATSHA204A crypto chip, using a userland driver
>> and i2c-dev, and with a NXP PCF8563 RTC using the kernel driver.
>
> Sounds good. Suspend/resume?
>

We don't have suspend/resume support yet for this SoC, so I haven't
been able to try that. Also, the clocks are fixed in this particular
implementation, so the clk_xxx() calls don't actually do anything.
