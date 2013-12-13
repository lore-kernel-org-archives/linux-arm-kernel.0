From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Fri, 13 Dec 2013 11:42:25 -0700
Subject: [PATCH V1 05/11] ARM: dts: imx6qdl-sabrelite: specify pad settings
In-Reply-To: <201312131248.32208.marex@denx.de>
References: <1386899355-17379-1-git-send-email-troy.kisky@boundarydevices.com>
 <1386899355-17379-6-git-send-email-troy.kisky@boundarydevices.com>
 <201312131248.32208.marex@denx.de>
Message-ID: <52AB5511.7040209@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13/2013 4:48 AM, Marek Vasut wrote:
> On Friday, December 13, 2013 at 02:49:09 AM, Troy Kisky wrote:
>> Don't use 0x80000000 to get default pad settings.
> What is the rationale behind this change please? Can you explain more in detail?
>
No real need, but I thought relying on what the boot loader did or did 
not do
was discouraged?

What is the value in not explicitly setting the pad registers?

Btw, I need to rebase series on your patch anyway so omitting this patch 
would be easy.


Thanks
Troy
