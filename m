From: eric@anholt.net (Eric Anholt)
Date: Wed, 18 May 2016 10:18:17 -0700
Subject: [PATCH v2] arm64: Allow for different DMA and CPU bus offsets
In-Reply-To: <20160518132741.GE22378@e104818-lin.cambridge.arm.com>
References: <1463576010-115428-1-git-send-email-agraf@suse.de>
 <20160518132741.GE22378@e104818-lin.cambridge.arm.com>
Message-ID: <874m9vp9nq.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Wed, May 18, 2016 at 02:53:30PM +0200, Alexander Graf wrote:
>> On arm64, all SoCs we supported so far either have an IOMMU or have bus
>> addresses equal to CPU addresses.
>> 
>> However, with the Raspberry Pi 3 coming up, this is no longer true. To
>> allow DMA to work with an AArch64 kernel on those devices, let's allow
>> devices to have DMA offsets again.
>> 
>> Signed-off-by: Alexander Graf <agraf@suse.de>
>
> We were aware about this issue but we've been waiting for an actual use
> case. I'll queue this for 4.8 (given that RPi3 is not supported by the
> arm64 kernel, I don't see the rush to merge it earlier).

Sounds good to me.  I'm looking forward to getting the other pieces in
place for 4.8.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160518/d6a194aa/attachment.sig>
