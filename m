From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 11 Jul 2014 16:00:11 +0800
Subject: [BUG] usb: gadget: rndis: atmel_usba_udc: probe of 500000.gadget
 failed with error -2
In-Reply-To: <53BF8890.9020409@aksignal.cz>
References: <53BF8890.9020409@aksignal.cz>
Message-ID: <53BF998B.2070006@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jiri Prchal,

On 07/11/2014 02:47 PM, Ji?? Prchal wrote:
> Hi,
> I discovered bug when I try to use RNDIS gadget driver on SAM9G25 with
> version 3.16.0-rc4. In version 3.14.0-rc4 it was OK.
> If I plug pc to device port on my board I expect to establish ethernet
> connection, instead of this it looks like it behave like host port. If I
> look at all messages I found some problem during boot:
> [    1.585937] atmel_usba_udc: probe of 500000.gadget failed with error -2

I tested OK with Linux kernel v3.16-rc4 (latest commit is: 
4f440cd534359f689cb577c68f8491d1eddf0b76) on sam9g25.

Best Regards,
Bo Shen
