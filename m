From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 27 Feb 2012 11:15:06 +0800
Subject: [PATCH] pxa/hx4700: Fix basic suspend/resume
In-Reply-To: <1330309969.41933.YahooMailClassic@web29005.mail.ird.yahoo.com>
References: <CAN1soZwTEppNZNHs5-_ORrNEt9x2rtV1omd6JGH_N4mzSSLD0w@mail.gmail.com>
 <1330309969.41933.YahooMailClassic@web29005.mail.ird.yahoo.com>
Message-ID: <CAN1soZzA9KMR2Y_WihT-xj2Ovyqtcc+Y-j2seia1=8ZHkEjGBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 10:32 AM, Paul Parsons <lost.distance@yahoo.com> wrote:
> Hello Haojian,
>
>> > What you want here is to keep the SPI chip select
>> deasserted (high)
>> > during suspend, so I think that should be DRIVE_HIGH
>> instead.
>> >
>> > Otherwise,
>> > Acked-by: Philipp Zabel <philipp.zabel@gmail.com>
>> >
>> This patch keeps a lot of devices in power-on mode (not
>> reset mode).
>> Is it necessary?
>
> No, of course not. This patch is just a first step to get hx4700 suspend
> mode working; currently it does not work at all.
>
> The suspend mode disposition of devices and GPIOs still needs to be
> reviewed at some point. For example, someone else discovered that the two
> Bluetooth outputs (GPIO43, GPIO45) account for approximately one third of
> the suspend mode power consumption! Correcting that will be my next patch.
>

Applied.
