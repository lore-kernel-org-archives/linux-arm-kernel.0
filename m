From: carlo@caione.org (Carlo Caione)
Date: Fri, 12 Sep 2014 08:59:07 +0200
Subject: [PATCH v2 3/9] ARM: meson: serial: add MesonX SoC on-chip uart
 driver
In-Reply-To: <20140911212534.GA17251@kroah.com>
References: <1410466300-19168-1-git-send-email-carlo@caione.org>
 <1410466300-19168-4-git-send-email-carlo@caione.org>
 <20140911212534.GA17251@kroah.com>
Message-ID: <CAOQ7t2a6ngA3CUWTAgwn=imJTQwfJK4_b=ig89tafky8fj7T_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 11:25 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, Sep 11, 2014 at 10:11:34PM +0200, Carlo Caione wrote:
>> The SoC has four fully functional UARTs which use the same programming
>> model. They are named UART_A, UART_B, UART_C and UART_AO (Always-On)
>> which cannot be powered off.
>>
>> Signed-off-by: Carlo Caione <carlo@caione.org>
>> ---
>>  drivers/tty/serial/Kconfig       |  18 ++
>>  drivers/tty/serial/Makefile      |   1 +
>>  drivers/tty/serial/meson_uart.c  | 634 +++++++++++++++++++++++++++++++++++++++
>>  include/uapi/linux/serial_core.h |   3 +
>>  4 files changed, 656 insertions(+)
>>  create mode 100644 drivers/tty/serial/meson_uart.c
>
> I've already taken this patch, why resend it?

Just for completeness' sake since there is also the documentation in
the patchset.
In the cover I specified that it was already taken.

I'll leave it out in v3 (if any).

-- 
Carlo Caione
