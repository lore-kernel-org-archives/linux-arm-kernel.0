From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 09 Jun 2014 12:14:43 +0200
Subject: [PATCH 0/9] ARM: Berlin: USB support
In-Reply-To: <20140609043019.GA32255@shlinux1.ap.freescale.net>
References: <1401983326-19205-1-git-send-email-antoine.tenart@free-electrons.com>
 <20140609043019.GA32255@shlinux1.ap.freescale.net>
Message-ID: <53958913.8080708@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/2014 06:30 AM, Peter Chen wrote:
> On Thu, Jun 05, 2014 at 05:48:37PM +0200, Antoine T?nart wrote:
>> This series adds the support for the Marvell Berlin USB controllers,
>> the USB PHYs and also adds a reset controller.
>>
>> The reset controller is used by the USB PHY driver and shares the
>> existing chip controller node with the clocks and one pin controller.
>>
>> The Marvell Berlin USB controllers are host only on the BG2Q and are
>> compatible with USB ChipIdea. We here add a glue to use the available
>> common functions for this kind of controllers. A USB PHY driver is also
>> added to control the PHY.
[...]
> 
> I am fine with 6/9, 7/9, will queue them if no other objections.
> 

Thanks Peter,

we are early in the cycle and I feel there will be a v2 of the
chipidea stub. IMHO, controlling the vbus regulator should not
be business of the phy driver, so ci will have to deal with it.

Anyways, good to know you are fine with it already!

Sebastian
