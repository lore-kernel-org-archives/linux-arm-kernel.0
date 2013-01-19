From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sat, 19 Jan 2013 01:11:54 +0100
Subject: [PATCH 5/6] arm: mvebu: Enable USB controllers on Armada XP
 OpenBlocks AX3-4 board
In-Reply-To: <CABMQnVLtXfs+bUsSm0xN6KRO8hCeaqy6xKbRaHS-qX0OdiZfbQ@mail.gmail.com>
References: <1358243670-11935-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1358243670-11935-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <CABMQnVLD+VKj53dfQC24AwCboed3EGt+gqTKt-B9q8nhEx3Ytg@mail.gmail.com>
 <CALF0-+XKGk+ru3VZ6815KTu_Aj_daYafr+Y5WJ9dXUoFqbTHOQ@mail.gmail.com>
 <20130116203713.7b396070@skate>
 <CABMQnVLtXfs+bUsSm0xN6KRO8hCeaqy6xKbRaHS-qX0OdiZfbQ@mail.gmail.com>
Message-ID: <50F9E4CA.6050006@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/19/2013 01:07 AM, Nobuhiro Iwamatsu wrote:
> Hi,
> 
> Thomas, Thank you for the detailed explanation.
> 
> Ezequiel, I checked your patch on OpenBlocks AX3, work fine.
> 
> But I have a question. your patch "arm: mvebu: Add support for USB
> host controllers in Armada 370/XP"
> was set USB controller of 0xd0050000 to IRQ 45. I think this is 47,
> and 0xd0052000 is 45.
> Because manual has been written irq 45 is USB2.
> I'm sorry if if my lack of understanding or typo in the manual.

It was a typo in the manual, and we have spent some time to figure
it out!


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
