From: dave.long@linaro.org (David Long)
Date: Mon, 03 Aug 2015 09:45:35 -0400
Subject: [RFC PATCH V2 00/10] ARM64: Uprobe support added
In-Reply-To: <55BF7019.9080007@linaro.org>
References: <cover.1434598237.git.panand@redhat.com>
 <20150803110908.GC10501@arm.com> <55BF7019.9080007@linaro.org>
Message-ID: <55BF707F.7020208@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/15 09:43, David Long wrote:
> On 08/03/15 07:09, Will Deacon wrote:
>> On Thu, Jun 18, 2015 at 04:58:47AM +0100, Pratyush Anand wrote:
>>> These patches have been prepared on top of ARM64 kprobe v7 patches [1].
>>> Keeping as RFC, because kprobe-v7 still need to be ACKed.
>>
>> Unfortunately, I've not seen any movement on the kprobes patches
>> recently,
>> so this is out of the picture for 4.3.
>>
>> Dave: did you plan to respin your series after Steve's comments on v7?
>>
>> Will
>>
>
> Catalin's comments last week helped me clarify in my own mind that we
> should be able to simplfy the register pushing somewhat. Will, does that
> also make sense to you?
>

^^ That question was aimed at Will Cohen, just to clarify.

> So, also taking into consideration Steve's suggestions about
> reorganizing the asm code, I am now working on a new revision.
>
> -dl
>
