From: robherring2@gmail.com (Rob Herring)
Date: Tue, 13 Mar 2012 17:54:47 -0500
Subject: [PULL] generic irq chip and pl061 irqdomain support
In-Reply-To: <4F5437FE.2000306@gmail.com>
References: <4F3ADFE7.4090409@gmail.com> <4F5437FE.2000306@gmail.com>
Message-ID: <4F5FD037.5000703@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2012 09:50 PM, Rob Herring wrote:
> Grant,
> 
> On 02/14/2012 04:27 PM, Rob Herring wrote:
>> Grant,
>>
>> Please pull. This is based on your current branch which you have said
>> you plan to rebase, so feel free to rebase these as you need to. This
>> has been tested on highbank and i.MX5.
>>
> 
> Ping.
> 
> I've rebased onto your current tree. Updated pull request:
> 
> The following changes since commit 280ad7fda5f95211857fda38960f2b6fdf6edd3e:
> 
>   mfd: twl-core: Add IRQ_DOMAIN dependency (2012-02-26 16:48:06 -0700)
> 
> are available in the git repository at:
>   git://sources.calxeda.com/kernel/linux.git irqdomain-for-grant
> 
> Rob Herring (3):
>       ARM: kconfig: always select IRQ_DOMAIN
>       irq: add irq_domain support to generic-chip
>       gpio: pl061: enable interrupts with DT style binding
> 
>  .../devicetree/bindings/gpio/pl061-gpio.txt        |   15 ++
>  arch/arm/Kconfig                                   |    2 +-
>  arch/arm/common/Kconfig                            |    2 -
>  drivers/gpio/gpio-pl061.c                          |   48 ++++---
>  include/linux/irq.h                                |   15 ++
>  kernel/irq/generic-chip.c                          |  152
> +++++++++++++++++---
>  6 files changed, 186 insertions(+), 48 deletions(-)
> 

Ping again...

Rob
