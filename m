From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 5 Jan 2017 16:19:58 +0800
Subject: [PATCH v6 08/14] ACPI: ARM64: IORT: rework iort_node_get_id()
In-Reply-To: <20170104175822.GD8604@red-moon>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
 <1483363905-2806-9-git-send-email-hanjun.guo@linaro.org>
 <20170104175822.GD8604@red-moon>
Message-ID: <41ea75c7-e371-a9a6-6143-af34c42ab59e@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On 2017/1/5 1:58, Lorenzo Pieralisi wrote:
> On Mon, Jan 02, 2017 at 09:31:39PM +0800, Hanjun Guo wrote:
>> iort_node_get_id() has two output, one is the mapped ids,
>> the other is the referenced parent node which is returned
>> from the function.
>>
>> For now we need a API just return its parent node for
>> single mapping, so just update this function slightly then
>> reuse it later.
>
> I think we need to fix iort_node_get_id() first though, I am referring
> to the index usage in relation to acpi_iort_id_mapping.output_reference
> and related parent pointer retrieval as you reported to me, I am happy
> to send it upstream independently.

Sure, please.

>
> As for this patch it is ok even though we can create an API that
> just retrieve a node parent without fiddling about with passing
> a NULL pointer for the id_out to achieve the same.

Since you commented "[PATCH v6 05/14] ACPI: platform-msi: retrieve dev
id from IORT" which also refer to this API, I will reply in that
email.

Thanks
Hanjun
