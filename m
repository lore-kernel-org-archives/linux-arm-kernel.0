From: archit@ti.com (Archit Taneja)
Date: Mon, 19 Nov 2012 10:51:08 +0530
Subject: [RFC] fbdev: arm has __raw I/O accessors, use them in fb.h
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F00206B2644F3F@AUSP01VMBX24.collaborationhost.net>
References: <1353057364-21214-1-git-send-email-archit@ti.com>
 <ADE657CA350FB648AAC2C43247A983F00206B2644F3F@AUSP01VMBX24.collaborationhost.net>
Message-ID: <50A9C1C4.5070907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 November 2012 10:14 PM, H Hartley Sweeten wrote:
> On Friday, November 16, 2012 2:16 AM, Archit Taneja wrote:
>>
>> This removes the sparse warnings on arm platforms:
>>
>> warning: cast removes address space of expression
>>
>> Signed-off-by: Archit Taneja <archit@ti.com>
>
> I submitted the same patch around early March 2012. So FWIW:
>
> Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Thanks.

Florian,

Could you queue this for 3.8 merge window?

Regards,
Archit
