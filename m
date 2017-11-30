From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 30 Nov 2017 17:56:59 +0800
Subject: why platform bus is called as virtual bus.
In-Reply-To: <CAA2oCOm8QwS8jm51NtNpcM=BRtJGgX4eNaKEqjsdkyQmRrpAnQ@mail.gmail.com>
References: <CAA2oCOm8QwS8jm51NtNpcM=BRtJGgX4eNaKEqjsdkyQmRrpAnQ@mail.gmail.com>
Message-ID: <CAGb2v66YmYbmPetJHWKgG+Ai29SVd7FyJWNC4YLJ2h0NFuHAoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 5:53 PM, Madhu K <madhu.sk89@gmail.com> wrote:
> Hi All,
>
> I have couple of doubts regarding platform bus.
>
> 1) In arm architecture, which bus we call it as platform bus?
> 2) Why platform bus is called as virtual bus?

The platform bus is a catch-all for devices that don't have a
real bus type, like PCI, I2C, SPI, etc., associated with it.

It is a construct within Linux, and unlike PCI which is a real
hardware bus, hence being called a "virtual" bus.

ChenYu

>
> can anybody please explain the above things.
>
> Thanks,
> Madhu
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
