From: robh@kernel.org (Rob Herring)
Date: Wed, 24 Feb 2016 08:53:46 -0600
Subject: [PATCH v4 16/17] FDT: Add a helper to get specified name subnode
In-Reply-To: <56CC3ED9.5000101@huawei.com>
References: <1454641552-12576-1-git-send-email-zhaoshenglong@huawei.com>
 <1454641552-12576-17-git-send-email-zhaoshenglong@huawei.com>
 <CAL_JsqK8F6PQX2kC_+CtDk1-ykKRB3YB54o4FaypsRY_tNzK5w@mail.gmail.com>
 <56CC3ED9.5000101@huawei.com>
Message-ID: <CAL_JsqJJx_agcQRa=vU25Db33t8LtaoBw+dZB5jS2N7LA2KX2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2016 at 5:13 AM, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
>
>
> On 2016/2/9 13:04, Rob Herring wrote:
>> On Thu, Feb 4, 2016 at 9:05 PM, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
>>> From: Shannon Zhao <shannon.zhao@linaro.org>
>>>
>>> Sometimes it needs to check if there is a node in FDT by full path.
>>
>> I'm confused. Are you searching by full path or...
>>
>>> Introduce this helper to get the specified name subnode if it exists.
>>
>> name of sub node?
>>
> get the offset of sub node by specified name.
>
>> Either way, fdt_subnode_offset or fdt_path_offset doesn't work?
>>
> Ah?right?both of them should work. Does it need to add a wrapper in
> drivers/of/fdt.c for them or directly use them with the parameter
> initial_boot_params?

Add a wrapper in fdt.c.

Rob
