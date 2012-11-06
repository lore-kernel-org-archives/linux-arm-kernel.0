From: lost.distance@yahoo.com (Paul Parsons)
Date: Tue, 06 Nov 2012 14:34:30 +0000
Subject: [GIT PULL][for 3.8] pull request from upload/board in arch-pxa
 git tree
In-Reply-To: <20121106140051.GB27284@quad.lixom.net>
References: <CAN1soZzhb361Gs9JVmhkjqqcr6FkGg9MVO_n9Tv29F==HdhwQQ@mail.gmail.com>
 <20121106140051.GB27284@quad.lixom.net>
Message-ID: <50991FF6.8070709@yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Olof,

On 06/11/12 14:00, Olof Johansson wrote:
> On Sun, Oct 28, 2012 at 07:59:54AM +0800, Haojian Zhuang wrote:
>> ----------------------------------------------------------------
>> Paul Parsons (1):
>>        ARM: pxa2xx: Remove EXPERIMENTAL dependency from spi-pxa2xx driver
>
> This is a SPI driver change, and should either go through or be acked by that
> maintainer. In this particular case, there's been several series of the
> EXPERIMENTAL removals, and I think Kees Cook has one that removes it for all
> options in one go. So please ack that patch instead.

According to the current MAINTAINERS file, the drivers/spi/spi-pxa2xx*
driver is maintained by the PXA2xx/PXA3xx guys.
That is why I submitted this patch to the linux-arm-kernel list.
Is the MAINTAINERS file incorrect?

Regards,
Paul
