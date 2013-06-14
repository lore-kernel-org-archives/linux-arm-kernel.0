From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 14 Jun 2013 23:46:31 +0200
Subject: [GIT PULL v2] at91: USBA DT support / drivers update for 3.11 #1
In-Reply-To: <20130611234851.GH23774@quad.lixom.net>
References: <20130526083430.GP24476@game.jcrosoft.org>
 <1370279139-7181-1-git-send-email-nicolas.ferre@atmel.com>
 <20130611234851.GH23774@quad.lixom.net>
Message-ID: <51BB8F37.2000505@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/2013 01:48, Olof Johansson :
> On Mon, Jun 03, 2013 at 07:05:39PM +0200, Nicolas Ferre wrote:
>> Arnd, Olof,
>>
>> This is a rework of the previous pull-request done by Jean-Christophe
>> PLAGNIOL-VILLARD last week ([GIT PULL] at91: USBA DT support for 3.11).
>> You should see that this material is based on the cleanup branch that you
>> already have in arm-soc/at91/cleanup.
>>
>> This adds the DT support for USBA gadget driver present in the most recent
>> AT91 SoCs.
>> As agreed with Arnd and Felipe we send these drivers updates via arm-soc.
>>
>> Thanks, best regards,
>>
>> The following changes since commit b3f442b0eedbc20b5ce3f4a96530588d14901199:
>>
>>    ARM: at91: udpate defconfigs (2013-05-17 15:05:08 +0200)
>>
>> are available in the git repository at:
>>
>>    git://github.com/at91linux/linux-at91.git tags/at91-drivers
>>
>> for you to fetch changes up to a375f12dde25a7e89acd75d066d0225657d7dfc2:
>>
>>    ARM: at91: sam9m10g45ek add udc DT support (2013-05-24 07:15:20 +0800)
>>
>> ----------------------------------------------------------------
>> Adding the DT support to UBB gadget High-Speed aka usba.
>> It updates the driver and all device tree files
>>
>> ----------------------------------------------------------------
>> Jean-Christophe PLAGNIOL-VILLARD (7):
>>        USB: gadget: atmel_usba: move global struct usba_ep usba_ep to struct usba_udc
>>        USB: gadget: atmel_usba: allow multi instance
>>        USB: gadget: atmel_usba: add DT support
>>        ARM: at91: sam9x5 add udc DT support
>>        ARM: at91: sam9x5ek add udc DT support
>>        ARM: at91: sam9g45 add udc DT support
>>        ARM: at91: sam9m10g45ek add udc DT support
>
> Hi,
>
> So, now you have multiple branches updating the DT files on at91, and they all
> conflict due to add/add or add/change.
>
> This branch is really two separate things already: three driver patches for
> next/drivers, and 4 devicetree updates that can go on top of the previous
> at91/dt branch. That should remove every DT conflict.
>
> Care to reshuffle?

Olof,

I try to rework this right now and send you two new pull-requests for 
these topics.

Bye,

-- 
Nicolas Ferre
