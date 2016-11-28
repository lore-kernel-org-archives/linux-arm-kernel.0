From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 28 Nov 2016 11:58:31 +0100
Subject: [PATCH] ARM: dts: mvebu: Add Armada 38x labels and clean up
 Turris Omnia
In-Reply-To: <e29e1a96-c9d5-d9b1-a42d-8afddc2714a7@kleine-koenig.org>
References: <1fc18002-0144-8300-1888-09f456860ef0@kleine-koenig.org>
 <1480272700-28888-1-git-send-email-afaerber@suse.de>
 <20161128103738.GT14217@n2100.armlinux.org.uk>
 <4ad1108a-43c4-46f8-4683-1c4b89996036@suse.de>
 <e29e1a96-c9d5-d9b1-a42d-8afddc2714a7@kleine-koenig.org>
Message-ID: <fb141a59-af81-2032-60be-44df10348c20@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 28.11.2016 um 11:54 schrieb Uwe Kleine-K?nig:
> On 11/28/2016 11:52 AM, Andreas F?rber wrote:
>> Would it help to split it back up into a series of add-labels,
>> use-labels like I had originally? Then you could start using them in
>> your refactoring as soon as the add-labels patch gets applied. Or are
>> you completely against this style?
> 
> I'd even go as far as:
> 
> 	1: add labels to .dtsi
> 	2: use labels on .dts#1
> 	3: use labels on .dts#2
> 	...

That was what I had in mind. :) I even considered reusing the existing
labels first, then adding more and converting more nodes.

Making the patches smaller will hopefully make them more easily
reviewable at the same time.

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
