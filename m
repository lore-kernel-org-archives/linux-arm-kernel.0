From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Wed, 5 Apr 2017 11:49:24 +0000
Subject: [7/7] crypto: caam/qi - add ablkcipher and authenc algorithms
In-Reply-To: <87lgrftbgl.fsf@concordia.ellerman.id.au>
References: <20170317100602.2837-8-horia.geanta@nxp.com>
 <87vaqkvk6c.fsf@concordia.ellerman.id.au> <58E39F90.6050408@nxp.com>
 <87lgrftbgl.fsf@concordia.ellerman.id.au>
Message-ID: <58E4D9C3.4070406@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/05/2017 01:06 PM, Michael Ellerman wrote:
> Laurentiu Tudor <laurentiu.tudor@nxp.com> writes:
>
>> Hi Michael,
>>
>> Just a couple of basic things to check:
>>    - was the dtb updated to the newest?
>
> Possibly not, it's an automated build/boot, I'll have to check what it
> does with the dtb.
>
>>    - is the qman node present? This should be easily visible in
>> /proc/device-tree/soc at ffe000000/qman at 318000.
>
> No it's not there.
>
> That's running linux-next with:
>
> CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_QI=n
>
>
> Does that mean I didn't update the device tree?
>

I think so. Also, I just checked that the node is actually there by 
compiling p5020ds.dts and then decompiling the dtb.

---
Best Regards, Laurentiu
