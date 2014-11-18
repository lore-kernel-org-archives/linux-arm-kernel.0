From: matthias.klein@linux.com (Matthias Klein)
Date: Tue, 18 Nov 2014 22:15:59 +0100
Subject: [PATCH v2] ARM: bcm2835: add device tree for Raspberry Pi model B+
In-Reply-To: <545B031E.9070409@wwwdotorg.org>
References: <1415231123-920-1-git-send-email-matthias.klein@linux.com>
 <545B031E.9070409@wwwdotorg.org>
Message-ID: <546BB70F.1080707@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Am 06.11.2014 um 06:11 schrieb Stephen Warren:
> On 11/05/2014 04:45 PM, Matthias Klein wrote:
>> The model B and B+ differ in the GPIO lines for ACT and PWR leds, and the
>> I2S interface.
> Tested-by: Stephen Warren <swarren@nvidia.com>
>
> (On a model B rev 2, UART, SD card, and enumeration of built-in USB
> devices works fine)
>
> Lee, how do you want to handle patches - will you apply them to the git
> repo?

Can you accept the patch, or do I have to rework something?
