From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 May 2017 17:48:30 +0200
Subject: [PATCH 1/4] ata: Add DT bindings for Faraday Technology FTIDE010
In-Reply-To: <6650456.qCJGCGKGLl@amdc3058>
References: <CGME20170506121118epcas2p1b2a2d1a8005a37582a73c0e7be4b1a1b@epcas2p1.samsung.com>
 <1678111.DmiVNKW3dQ@amdc3058>
 <CACRpkdbmOsrxKX8=a7bvcF+c=Q2tfwYQVt0=cz+_jhDyadwa2A@mail.gmail.com>
 <6650456.qCJGCGKGLl@amdc3058>
Message-ID: <CACRpkdbyPcC5FiqQ0khkNh4OvXeft_p4uwwH_yvpiiePkHcRhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 10, 2017 at 3:59 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> On Monday, May 08, 2017 10:26:49 PM Linus Walleij wrote:
>> On Mon, May 8, 2017 at 12:47 PM, Bartlomiej Zolnierkiewicz
>> <b.zolnierkie@samsung.com> wrote:

>> So depending on whether they use an FPGA or an ASIC the values are
>> different, no matter what frequency (50 or 66 MHz) is used. So it is not
>> derived from frequency.
>>
>> So I think it makes most sense to have it in the device tree as we don't
>> know what designs are out there.
>
> I still would prefer to keep timing values private to the driver and just
> select the controller type (FPGA/ASIC) using the device tree.

OK I'll revert to static timings in the driver, no problem.

Yours,
Linus Walleij
