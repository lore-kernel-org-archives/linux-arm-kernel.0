From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Fri, 13 May 2011 11:25:30 +0200
Subject: [RFC PATCH v3] Consolidate SRAM support
In-Reply-To: <20110513091123.GA20941@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<20110512174546.GB8633@n2100.arm.linux.org.uk>
	<BANLkTimmCuxUUY46B+aY5C0KxnY4_Dvucg@mail.gmail.com>
	<20110513091123.GA20941@n2100.arm.linux.org.uk>
Message-ID: <BANLkTi=0-dFd2XG7U7=eAy2XS_sakqmekA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 13, 2011 at 11:11 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, May 13, 2011 at 09:30:14AM +0200, Jean Pihet wrote:
>> On Thu, May 12, 2011 at 7:45 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > ? ?This version fixes the davinci pm free, and adds updates for the
>> > ? ?davinci pcm driver. ?As I don't know what's happening with Jean's
>> > ? ?patch tweaking the genpool allocator, I've kept my version.
>>
>> Sorry I do not get the question. The latest changes I submitted have
>> been merged in mainline as 'ARM: 6649/1: omap: use fncpy to copy the
>> PM code functions to SRAM' [1] . Thanks for that!
>> This change is only about the simple linear SRAM allocator, not the
>> genpool allocator.
>
> The wrong Jean! ?I meant Jean-Christophe PLAGNIOL-VILLARD.
Ok, sorry about that!

Regards,
Jean

>
