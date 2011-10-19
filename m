From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 20 Oct 2011 00:02:12 +0200
Subject: [PATCH v2] UART: add CSR SiRFprimaII SoC on-chip uart drivers
In-Reply-To: <CAGsJ_4xJzL6dfSmmae8LH6kt2g1PmevgrFWgYLR3Tif8PD0bCQ@mail.gmail.com>
References: <1318570799-3785-1-git-send-email-Barry.Song@csr.com>
	<CAGsJ_4w6fGH+G9KapHXzCwMhz_NKfPdCxs7rF5hWKw2LGUpwWA@mail.gmail.com>
	<20111018181319.GA7015@kroah.com>
	<CAGsJ_4xJzL6dfSmmae8LH6kt2g1PmevgrFWgYLR3Tif8PD0bCQ@mail.gmail.com>
Message-ID: <CAKnu2MqUW=6tH0A1Zae0MgMyKiU4X26c0jGCQFKeJrxJA2GyzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/19 Barry Song <21cnbao@gmail.com>:
> 2011/10/19 Greg KH <greg@kroah.com>:
>> So should it go through the pinmux tree? ?Or do you want to wait for the
>> 3.3 kernel release to get this merged?
>
> i think we can go ahead through Linux W's pinmux tree. Linus, would
> you like to take care once Alan ack this.

It's a bit late, and I don't know if Torvalds will pull my pin control tree
yet, that's uncertain since it's an all new subsystem. It's stabilizing
for the merge window.

I would suggest that you see if my tree gets pulled in the merge
window, and if and when it does, send the patch as a single patch
directly to Torvalds with Alan's ACK and explain the situation
with cross-dependence and all.

Linus Walleij
