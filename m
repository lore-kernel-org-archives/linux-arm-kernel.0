From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 05 Mar 2014 03:10:15 +0300
Subject: [PATCH] irq-gic: remove file name from heading comment
In-Reply-To: <52D5CCFB.1090205@cogentembedded.com>
References: <201312140224.53928.sergei.shtylyov@cogentembedded.com>
 <52D5CCFB.1090205@cogentembedded.com>
Message-ID: <53166B67.2060804@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01/15/2014 02:49 AM, Sergei Shtylyov wrote:

>> File names in the heading comments  fell out of favor long ago, and this one
>> weren't even changed when the driver was moved from arch/arm/common/, so remove
>> it at last...

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> ---
>> The patch is against the 'irq/core' branch of the 'tip.git' repo.

>     Thomas, is there a chance that you merge this patch for 3.14? Is it even
> the right branch for cleanups (I'm seeing fixes there)?

    Thomas, will you ever reply to me? Who's maintaining the GIC driver, you?
Or the patches shoud just go in via arm-soc.git?

WBR, Sergei
