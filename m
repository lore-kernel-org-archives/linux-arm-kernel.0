From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 30 Aug 2013 11:46:13 +0100
Subject: [PATCH v7 2/4] drivers: of: add function to scan fdt nodes given
 by path
In-Reply-To: <5220770F.9080806@samsung.com>
References: <1377527959-5080-1-git-send-email-m.szyprowski@samsung.com>
 <1377527959-5080-3-git-send-email-m.szyprowski@samsung.com>
 <20130829214007.CDB813E1222@localhost> <5220770F.9080806@samsung.com>
Message-ID: <CACxGe6tdk8JbtfrB4s8BoRiAVN5KKUo=5C3AXH7qHBNkzT-VSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 30, 2013 at 11:42 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hello,
>
>
> On 8/29/2013 11:40 PM, Grant Likely wrote:
>>
>> On Mon, 26 Aug 2013 16:39:17 +0200, Marek Szyprowski
>> <m.szyprowski@samsung.com> wrote:
>> > Add a function to scan the flattened device-tree starting from the
>> > node given by the path. It is used to extract information (like reserved
>> > memory), which is required on early boot before we can unflatten the
>> > tree.
>> >
>> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> > Acked-by: Michal Nazarewicz <mina86@mina86.com>
>> > Acked-by: Tomasz Figa <t.figa@samsung.com>
>> > Reviewed-by: Rob Herring <rob.herring@calxeda.com>
>>
>> Some nits below, but otherwise:
>>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>
>
> Thanks!
>
>
>> I'm happy to take this through the DT tree, or have you take it via the
>> CMA tree.
>
>
> I have already put the whole patchset in linux-next via my dma-mapping/cma
> tree,
> so I would like to keep it there to avoid further confusion.
>
> I only wonder how to handle the patches to get them merged to v3.12-rc1.
> After your review there will be some changes to the binding, its
> documentation
> and the code itself. Would you mind if I send pull request with the current
> version and then provide incremental patches to fix the issues you have
> reported? Or should we delay this patchset till v3.13-rc1?

Merge the series as-is and send follow-on patches. If you can get the
fixups done quickly, then we can get them merged for v3.12 also.

g.
