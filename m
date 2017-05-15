From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 15 May 2017 16:35:05 +0300
Subject: [PATCH V2 1/6] tty: serial: lpuart: introduce lpuart_soc_data to
 represent SoC property
In-Reply-To: <1494834539-17523-2-git-send-email-aisheng.dong@nxp.com>
References: <1494834539-17523-1-git-send-email-aisheng.dong@nxp.com>
 <1494834539-17523-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CAHp75VejaaBPvO3qBxwBTDR9bq_nr0bT7uSKi66tnA=_S96W5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 10:48 AM, Dong Aisheng <aisheng.dong@nxp.com> wrote:
> This is used to dynamically check the SoC specific lpuart properies.
> Currently only the checking of 32 bit register width is added which
> functions the same as before. More will be added later for supporting
> new chips.

For the rest it might be okay, but don't we have specific properties
for register width and offset for UART? I think I saw something like
that in other drivers.

-- 
With Best Regards,
Andy Shevchenko
