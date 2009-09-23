From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 23 Sep 2009 21:48:11 +0200
Subject: [PATCH] mach-iop32x/ Add nec ns-50 / ApplianceWare sanmina support
In-Reply-To: <e9c3a7c20908301646w3cc8199dg392b95faad5616de@mail.gmail.com>
	(Dan Williams's message of "Sun\, 30 Aug 2009 16\:46\:59 -0700")
References: <87ocr6uyhx.fsf@lechat.rtp-net.org>
	<e9c3a7c20908301646w3cc8199dg392b95faad5616de@mail.gmail.com>
Message-ID: <87hbut7890.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dan Williams <dan.j.williams@intel.com> writes:

Hi,

> On Mon, Jul 27, 2009 at 5:00 AM, Arnaud Patard<arnaud.patard@rtp-net.org> wrote:
>> Hi,
>>
>> This patch is adding support for the nec ns-50/ApplianceWare Sanmina
>> platform. This platforms is a nas based on iop80219 SoC.
>>
>> This code has been tested on 2.6.31-rc*
>>
>
> Looks ok to me except for the bit modifying arch/arm/tools/mach-types.

oops. Sent the wrong patch :(

New patch attached below.

Arnaud



This patch is adding support for the nec ns-50/ApplianceWare Sanmina
platform. This platforms is a nas based on iop80219 SoC.


Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
---
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sanmina.patch
Type: text/x-diff
Size: 8050 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090923/41e60f51/attachment-0001.bin>
