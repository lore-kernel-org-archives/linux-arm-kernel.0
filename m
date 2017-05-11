From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Thu, 11 May 2017 16:44:00 +0200
Subject: [PATCH v3 0/7] ARM: Fix dma_alloc_coherent() and friends for NOMMU
In-Reply-To: <73e1eed0-9d21-6d36-d596-3ca40eb24075@arm.com>
References: <1489137839-549-1-git-send-email-vladimir.murzin@arm.com>
 <90e219f3-7139-c11c-a635-509173d4148a@arm.com>
 <33321273-E3E7-459B-A615-5ADA52445AA1@esh.hu>
 <186f0c06-39ce-cb88-35e5-6dd57aa81166@arm.com>
 <4e3ce329-6194-043b-0d69-cbec6b08e38e@arm.com>
 <21ea43fb-0d3d-88e2-12ee-4a114e9d8459@arm.com> <20170419115658.GD5077@suse.de>
 <73e1eed0-9d21-6d36-d596-3ca40eb24075@arm.com>
Message-ID: <CA+M3ks7d9P0TxRd4irco-OXKCDH-eUYCGUYXCY23Ei2-9EqGoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-04-19 16:20 GMT+02:00 Vladimir Murzin <vladimir.murzin@arm.com>:
> On 19/04/17 12:56, Joerg Roedel wrote:
>> On Tue, Apr 18, 2017 at 01:51:35PM +0100, Vladimir Murzin wrote:
>>> FYI, nothing has changed since last "ping" - Andr?s and Alexandre are still
>>> dependant on this series to safely enable DMA on their platforms. It is really
>>> scary that these patches do not move forward even though they are supposed to
>>> fix the real issue :(
>>
>> That's probably because you didn't include all relevant people in this
>> post. I think patches the patches for dma-noop.c should go through
>> Andrew Morton.
>>
>
> Thanks for suggestion, Joerg! Andrew is already in the loop.
>
> I'm wondering if there is better way/tool to get relevant people except
> get_maintainer.pl?
>
> ./scripts/get_maintainer.pl -f lib/dma-noop.c
> Bart Van Assche <bart.vanassche@sandisk.com> (commit_signer:3/3=100%,authored:2/3=67%,added_lines:2/7=29%,removed_lines:2/6=33%)
> Vineet Gupta <vgupta@synopsys.com> (commit_signer:2/3=67%)
> Robin Murphy <robin.murphy@arm.com> (commit_signer:2/3=67%)
> Doug Ledford <dledford@redhat.com> (commit_signer:2/3=67%)
> Joerg Roedel <jroedel@suse.de> (commit_signer:2/3=67%)
> Krzysztof Kozlowski <krzk@kernel.org> (authored:1/3=33%,added_lines:5/7=71%,removed_lines:4/6=67%)
> linux-kernel at vger.kernel.org (open list)
>
> ./scripts/get_maintainer.pl -f drivers/base/dma-coherent.c
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS)
> linux-kernel at vger.kernel.org (open list)
>
> Cheers
> Vladimir

May I ask what is the status of those patches ?
Any chance to get them merged ?

Regards,
Benjamin

>
>>
>>
>>       Joerg
>>
>>
>
