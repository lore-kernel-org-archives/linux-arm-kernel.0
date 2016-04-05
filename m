From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Tue, 5 Apr 2016 09:16:58 +0800
Subject: [PATCH 1/2] dt/bindings: Add bindings for hisilicon random number
 generator
In-Reply-To: <20160404051549.GF17806@rob-hp-laptop>
References: <1459474664-11264-1-git-send-email-wangkefeng.wang@huawei.com>
 <20160404051549.GF17806@rob-hp-laptop>
Message-ID: <5703120A.6040803@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/4/4 13:15, Rob Herring wrote:
> On Fri, Apr 01, 2016 at 09:37:43AM +0800, Kefeng Wang wrote:
>> Document the devicetree bindings for the random number generator
>> found on Hisilicon Hip04 and Hip05 soc.
[...]
>> +
>> +Required properties:
>> +- compatible : Should be "hisilicon,hisi-rng"
> 
> hisi is a bit redundant with hisilicon and please define SoC specific 
> compatible strings.

Due to it exists in both Hip04/Hip05 soc(and maybe some other chips),
how about drop hisi-, just "hisilicon,rng".

Thanks

> 
>> +- reg : Offset and length of the register set of this block
>> +
>> +Example:
>> +
>> +rng at d1010000 {
>> +	compatible = "hisilicon,hisi-rng";
>> +	reg = <0xd1010000 0x100>;
>> +};
>> -- 
>> 1.7.12.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 
