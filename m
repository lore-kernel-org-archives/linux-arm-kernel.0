From: viresh.kumar@st.com (viresh kumar)
Date: Mon, 25 Oct 2010 14:09:31 +0530
Subject: [PATCH V2 00/69] Updating SPEAr Support
In-Reply-To: <4CB4066A.80007@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com> <4CB4066A.80007@st.com>
Message-ID: <4CC54243.10704@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/2010 12:25 PM, Viresh KUMAR wrote:
> On 10/01/2010 05:25 PM, Viresh KUMAR wrote:
>> Following set of patches:
>> - updates SPEAr3xx, 6xx support
>> - Adds support for SPEAr13xx
>> - Removes Multiple defconfigs per machine family
>>
>> Changes since V1:
>> - sev definitions moved to system.h and removed from spear and omap archs
>> - bug fix added in system controller file sp810.h
>> - Review Comments incorporated
>> - Driver and machine support are divided into separate patches
>> - Nand Driver is removed from patch list as it is already floated by Linus
>>   Walleij.
>> - Few later patches of SPEAr13xx Patches are merged with initial patches of
>>   SPEAr13xx
>> - Smaller Defconfigs are used instead of large.
>> - Clock renaming & minor corrections are moved to clock specific patches from
>>   peripheral machine support patches.
>> - Removed Commented code related to SPI
>> - [PATCH] Incrementing the ecc_pos array to contain 128 char - is removed from
>>   list
>> - Board specific code is moved to *evb.c files from machine files for EMI NOR
>> - replaced readl with __raw_readl in uncompress.h in plat-spear/include/plat/
> 
> Russell,
> 
> Are there open points in these v2 patches or are they fine?
> 

Russell,

Are there open points in these v2 patches or are they fine?

-- 
viresh
