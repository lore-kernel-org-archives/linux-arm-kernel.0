From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 15 Jan 2014 02:49:15 +0300
Subject: [PATCH] irq-gic: remove file name from heading comment
In-Reply-To: <201312140224.53928.sergei.shtylyov@cogentembedded.com>
References: <201312140224.53928.sergei.shtylyov@cogentembedded.com>
Message-ID: <52D5CCFB.1090205@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/14/2013 02:24 AM, Sergei Shtylyov wrote:

> File names in the heading comments  fell out of favor long ago, and this one
> weren't even changed when the driver was moved from arch/arm/common/, so remove
> it at last...

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> ---
> The patch is against the 'irq/core' branch of the 'tip.git' repo.

    Thomas, is there a chance that you merge this patch for 3.14? Is it even 
the right branch for cleanups (I'm seeing fixes there)?

WBR, Sergei
