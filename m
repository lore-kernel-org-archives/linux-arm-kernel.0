From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 27 Nov 2016 20:02:09 +0100
Subject: [PATCH v5 2/2] ARM: dts: add support for Turris Omnia
In-Reply-To: <1fc18002-0144-8300-1888-09f456860ef0@kleine-koenig.org>
References: <20161125142658.21690-1-uwe@kleine-koenig.org>
 <20161125142658.21690-3-uwe@kleine-koenig.org>
 <87lgw7ilg9.fsf@free-electrons.com>
 <a7f47999-ec83-6cc8-8119-0087dee17bac@suse.de>
 <1fc18002-0144-8300-1888-09f456860ef0@kleine-koenig.org>
Message-ID: <5cbc476d-096a-742d-a90e-fb9356f013f5@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 27.11.2016 um 17:05 schrieb Uwe Kleine-K?nig:
>> @Gregory: Can we please follow up with cleaning up these ugly
>> internal-regs and pcie-controller nodes for consistency?
> 
> I bet the answer will be: Please send your patches to lakml for review.

Done for the node labels, covering the complete set of 38x boards now.

Well, the implied question was: Why did no one point this out during
review? We had that discussion for 3700 and 7k/8k already.

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161127/a5465465/attachment.sig>
