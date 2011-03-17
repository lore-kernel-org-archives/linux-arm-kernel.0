From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Thu, 17 Mar 2011 22:50:52 +0100
Subject: [PATCH 1/9] lpc2k: Core support
In-Reply-To: <AANLkTik1fJKs81fRW+a6N24tFf-wmG+c4p68kVOAxqeA@mail.gmail.com>
References: <1300377264-10843-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300377264-10843-2-git-send-email-ithamar.adema@team-embedded.nl>
	<AANLkTik1fJKs81fRW+a6N24tFf-wmG+c4p68kVOAxqeA@mail.gmail.com>
Message-ID: <1300398652.2138.92.camel@team-embedded-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-03-17 at 22:32 +0100, Vitaly Wool wrote:
> is there any good reason why you don't add your stuff to lpc32xx?

Most of the code (interrupt controller, clocks, etc) are completely
different on the ARM7TDMI based LPC2K socs compared to the ARM9 based
LPC3K SoCs. One of the only things that is fairly similar is the timers
block ;-)

I've looked at solutions introducing a plat-lpc directory but it ended
up introducing more "red tape" then actual shared code...

Regards,

Ithamar.
