From: eric@anholt.net (Eric Anholt)
Date: Tue, 10 Apr 2018 12:39:22 -0700
Subject: [PATCH 1/3] drm/vc4: Remove the need for the GPU-subsystem DT
 node.
In-Reply-To: <8806871.109949.1523384893773@email.1und1.de>
References: <20180409230040.1100-1-eric@anholt.net>
 <8806871.109949.1523384893773@email.1und1.de>
Message-ID: <87efjmq2ad.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Eric,
>
>> Eric Anholt <eric@anholt.net> hat am 10. April 2018 um 01:00 geschrieben:
>> 
>> 
>> The GPU subsystem node was a workaround to have a central device to
>> bind V3D and display to.  Following the lead of 246774d17fc0
>> ("drm/etnaviv: remove the need for a gpu-subsystem DT node"), remove
>> the subsystem node usage and just create a platform device for the DRM
>> device to attach to if any of the subsystem devices are present.
>
> i didn't test it. Does the code change keep the backward compatibility with older DT?

Yes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180410/77e2b6df/attachment.sig>
