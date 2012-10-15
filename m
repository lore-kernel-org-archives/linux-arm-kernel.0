From: stigge@antcom.de (Roland Stigge)
Date: Mon, 15 Oct 2012 20:15:45 +0200
Subject: [PATCH RFC 2/6 v3] gpio: Add sysfs support to block GPIO API
In-Reply-To: <20121015180702.GA12801@game.jcrosoft.org>
References: <1350069085-13283-1-git-send-email-stigge@antcom.de>
 <1350069085-13283-3-git-send-email-stigge@antcom.de>
 <20121015180702.GA12801@game.jcrosoft.org>
Message-ID: <507C52D1.4050104@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2012 08:07 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 21:11 Fri 12 Oct     , Roland Stigge wrote:
>> This patch adds sysfs support to the block GPIO API.
>>
>> Signed-off-by: Roland Stigge <stigge@antcom.de>
>>
>> ---
>>  Documentation/ABI/testing/sysfs-gpio |    6 
>>  drivers/gpio/gpiolib.c               |  226 ++++++++++++++++++++++++++++++++++-
>>  include/asm-generic/gpio.h           |   11 +
>>  include/linux/gpio.h                 |   13 ++
>>  4 files changed, 254 insertions(+), 2 deletions(-)
> I really don't like this sysfs we need to add a specific device with ioctl

The good thing about the current style is that you have a single value
for the whole block in a single file just as for single GPIOs. You can
consider it as a generalized GPIO.

And I like it. :-)

Thanks for considering,

Roland
