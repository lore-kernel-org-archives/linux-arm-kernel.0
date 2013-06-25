From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Tue, 25 Jun 2013 07:53:47 +0100
Subject: [PATCH v4 0/7] ARM:STixxxx: Add STixxxx platform and board support
In-Reply-To: <20130624175415.GA31429@quad.lixom.net>
References: <1371811076-27168-1-git-send-email-srinivas.kandagatla@st.com>
 <20130624175415.GA31429@quad.lixom.net>
Message-ID: <51C93E7B.30709@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/06/13 18:54, Olof Johansson wrote:
> On Fri, Jun 21, 2013 at 11:37:56AM +0100, Srinivas KANDAGATLA wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>>
>> Thankyou all for reviewing the v3 patches.
>>
>> This patch-set adds basic support for STMicroelectronics STixxxx SOCs
>> which includes STiH415 and STiH416 with B2000 and B2020 board support.
>>
>> STiH415 and STiH416 are dual-core ARM Cortex-A9 CPU, designed for use in
>> Set-top-boxes. The SOC support is available in mach-stixxxx which contains
>> support code for STiH415, STiH416 SOCs including the generic board support.
>>
>> The reason for adding two SOCs at this patch set is to show that no new
>> C code is required for second SOC(STiH416) support.
>>
>> This patch-set only contains the SOC support, all the driver support for
>> this platform are submitted to respective mailing lists.
> 
> Hi,
> 
> I think these are looking quite reasonable, and I am ready to apply them
> to 3.11.
> 
> However, I have one bikeshed comment. I find the name of the platform to be
> awkward. Would you mind naming it mach-sti instead?
Am OK to rename them,
But, I see the patches on arm-soc for-next branch.

Thanks,
srini


> 
> 
> -Olof
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
