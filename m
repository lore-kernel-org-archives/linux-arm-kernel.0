From: eric@anholt.net (Eric Anholt)
Date: Tue, 31 Jan 2017 10:40:00 -0800
Subject: [PATCH 1/4] dt-bindings: Add binding for brcm,bcm2835-sdhost.
In-Reply-To: <2012885435.15821.1485812279271@email.1und1.de>
References: <1485516989-1072-1-git-send-email-kraxel@redhat.com>
 <1485516989-1072-2-git-send-email-kraxel@redhat.com>
 <2012885435.15821.1485812279271@email.1und1.de>
Message-ID: <87zii7m5tr.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

>> Gerd Hoffmann <kraxel@redhat.com> hat am 27. Januar 2017 um 12:36 geschrieben:
>> 
>> 
>> From: Eric Anholt <eric@anholt.net>
>> 
>> This is the other SD controller on the platform, which can be swapped
>> to the role of SD card host using pin muxing.
>
> AFAIK the SDHOST controller isn't able to handle SDIO. Maybe we should mention this in the binding document.

The binding should be documentation of the binding.  I'd love to see
more explanation in the mmc/host/bcm2835.c, though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170131/f91e0ad6/attachment.sig>
