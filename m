From: ethan@ethantuttle.com (Ethan Tuttle)
Date: Mon, 16 Sep 2013 09:35:16 -0700
Subject: mvneta: oops in __rcu_read_lock on mirabox
In-Reply-To: <20130916175152.4e013457@skate>
References: <CACzLR4tTvt+ROEhkXUCQhV6=bPPTX4LFSkWfrEhF+OdM1Jm1Rw@mail.gmail.com>
 <20130915205701.5c61a444@skate> <20130916065047.GH27487@1wt.eu>
 <20130916175152.4e013457@skate>
Message-ID: <CACzLR4twTNjzU8hK3L1cYUXnEH1ydwY6jnYoOG+9vLB3-4uQ4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 16, 2013 at 8:51 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Willy, Ethan,
>
> On Mon, 16 Sep 2013 08:50:47 +0200, Willy Tarreau wrote:
>
>> I'm currently testing on 3.11.1 (which I had here) and am not getting
>> any issue after 50M packets. My kernel is running in thumb mode and
>> without SMP.
>>
>> Ethan, we'll need your config I guess.
>
> Can both of you also report the U-Boot version you're using, and the
> SoC revision (it's visible in the U-Boot output).

Mine says:

U-Boot 2009.08 (Sep 16 2012 - 22:50:06)Marvell version: 1.1.2 NQ
SoC:   MV6710 A1

> Maybe Globalscale is
> shipping Mirabox with a different version of the bootloader, or some
> hardware difference, that is causing problems? (I'm just speculating
> here, but another user already reported having issues with his Mirabox,
> and Russell King analyzed the oops as very likely being hardware
> problems).
>
> Thomas
> --
> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
