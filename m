From: wni@nvidia.com (Wei Ni)
Date: Tue, 19 Feb 2013 17:58:36 +0800
Subject: [RFC PATCH 4/9] hwmon: (lm90) use macros for the indexes of temp8
 and temp11
In-Reply-To: <5123100A.9050604@nvidia.com>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com>
 <1361187031-3679-5-git-send-email-wni@nvidia.com>
 <5123100A.9050604@nvidia.com>
Message-ID: <51234CCC.2060909@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/2013 01:39 PM, Alex Courbot wrote:
> On 02/18/2013 08:30 PM, Wei Ni wrote:
>> Using macros for the indexes and nrs of temp8 and temp11.
>> This make the code much clearer.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
> 
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
> 
> Great patch. This makes the code much more readable. I also compiled 
> lm90.o before and after this patch, and diff'ed the stripped binaries to 
> make sure there was no error in the macro indexes. Both binaries were 
> indentical, therefore:
> 
> Tested-by: Alexandre Courbot <acourbot@nvidia.com>

Great, thanks for your test, I will do it in my next version.

Wei.

> 
> Alex.
> 
> 
