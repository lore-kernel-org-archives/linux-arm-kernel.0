From: eric@anholt.net (Eric Anholt)
Date: Tue, 29 Nov 2016 14:12:46 -0800
Subject: [PATCH V8 2/6] thermal: bcm2835: add thermal driver for bcm2835
 soc
In-Reply-To: <20161129013436.GA3080@localhost.localdomain>
References: <1478081906-12009-1-git-send-email-kernel@martin.sperl.org>
 <1478081906-12009-3-git-send-email-kernel@martin.sperl.org>
 <20161117021107.GA2647@localhost.localdomain>
 <766e1b70-d83a-eb52-fa2b-aec435e85673@martin.sperl.org>
 <20161117151019.GA3115@localhost.localdomain>
 <7957B3CC-0E18-4B27-82EB-EF88B7695E28@martin.sperl.org>
 <20161119042224.GA25063@localhost.localdomain>
 <28F93ABE-8210-4389-AE77-4D5E830E669B@martin.sperl.org>
 <20161125052008.GA8342@localhost.localdomain>
 <87twarz6s1.fsf@eliezer.anholt.net>
 <20161129013436.GA3080@localhost.localdomain>
Message-ID: <87lgw2lyu9.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eduardo Valentin <edubezval@gmail.com> writes:

> Hello Eric, Martin,
>
> On Mon, Nov 28, 2016 at 12:30:38PM -0800, Eric Anholt wrote:
>> Either the device was initialized by the firmware before handing off to
>> ARM (today's firmware) or it never will be (potential future firmware).
>
> And do you have a way to check if the firmware has the initialization
> code or not? By firmware version, for example. Or even, chip version,
> maybe?

We would know if it's not present because the register would be in its
power-on reset state, which is what the code is checking for.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161129/63bdda2f/attachment.sig>
