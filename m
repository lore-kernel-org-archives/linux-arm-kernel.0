From: mw@semihalf.com (Marcin Wojtas)
Date: Wed, 4 Mar 2015 13:12:10 +0100
Subject: [PATCH 2/4] ARM: mvebu: add audio I2S controller to Armada 38x
 Device Tree
In-Reply-To: <20150228105844.3749a825@free-electrons.com>
References: <1424901482-3809-1-git-send-email-mw@semihalf.com>
 <1424901482-3809-3-git-send-email-mw@semihalf.com>
 <54EE4AD6.6090101@gmail.com>
 <CAPv3WKf8b+fuB-4qVwKC57iKaNHTLZAf9VFpfDbow1Sb3YAsNw@mail.gmail.com>
 <54EE6942.9080800@gmail.com>
 <CAPv3WKezrx4jkZNo3PYSOGZtiSJH09+94BaknYNN4xPkB1AxKw@mail.gmail.com>
 <20150227150303.2c4ea0e7@free-electrons.com>
 <CAPv3WKeLfFsxcC5gvZeP9DZqysZ0XtashByppeuDzRfvjxjujg@mail.gmail.com>
 <20150228105844.3749a825@free-electrons.com>
Message-ID: <CAPv3WKfEBXMbRzFeQioV5ZBVWpKMebcTkAQmyMhYwkObyyBKWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thomas,

2015-02-28 10:58 GMT+01:00 Thomas Petazzoni
<thomas.petazzoni@free-electrons.com>:
> Dear Marcin Wojtas,
>
> On Fri, 27 Feb 2015 21:22:30 +0100, Marcin Wojtas wrote:
>
>> Given all the facts, do you think that drivers/clk/mvebu/armada-38x.c
>> is a right place for adding this PLL setting support?
>
> Yes, sounds right to me. I was thinking that maybe it should be in a
> separate file armada-38x-pll.c, but that's probably a bit too much for
> something that is causing to be a simple driver.
>

I've got an update from Marvell - TDM and Audio are available in A39x
and it has the same set of PLL registers like A38x. Shouldn't we place
PLL configuration code in a separate file like clk-pll.c, or whatever
name you suggest?

> Have you sorted out how to handle the pin-muxing part of the problem?
>

I'll come back with this issue after implementing poc.

Best regards,
Marcin
