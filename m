From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Tue, 23 Jul 2013 08:23:31 +0100
Subject: [PATCH v2 2/2] ARM: STi: Set correct ARM ERRATAs.
In-Reply-To: <20130723023540.GA14983@quad.lixom.net>
References: <1373354752-26292-1-git-send-email-srinivas.kandagatla@st.com>
 <1373354793-26400-1-git-send-email-srinivas.kandagatla@st.com>
 <20130723023540.GA14983@quad.lixom.net>
Message-ID: <51EE2F73.9070600@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 23/07/13 03:35, Olof Johansson wrote:
> On Tue, Jul 09, 2013 at 08:26:33AM +0100, Srinivas KANDAGATLA wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>>
>> Some of the ARM_ERRATA selection is not done in the initial SOC support
>> patches. This patch selects 2 new ARM_ERRATA's and removes one which was
>> actually fixed.
> 
> These entries should be sorted, and you inserted in random order.
Thanks Olof.
I will take a note of it.

> 
> I'll rearrange the order when applying.
> 
> (Patch applied with that change).
> 
> Thanks,
> 
> -Olof
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
