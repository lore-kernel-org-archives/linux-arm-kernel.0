From: cyril@ti.com (Cyril Chemparathy)
Date: Mon, 24 Sep 2012 10:00:08 -0400
Subject: [PATCH v3 RESEND 09/17] ARM: LPAE: use phys_addr_t for initrd
 location and size
In-Reply-To: <20120924133826.GA26454@n2100.arm.linux.org.uk>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
 <1348242975-19184-10-git-send-email-cyril@ti.com>
 <20120924133826.GA26454@n2100.arm.linux.org.uk>
Message-ID: <50606768.3080300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/12 09:38, Russell King - ARM Linux wrote:
> On Fri, Sep 21, 2012 at 11:56:07AM -0400, Cyril Chemparathy wrote:
>> From: Vitaly Andrianov <vitalya@ti.com>
>>
>> This patch fixes the initrd setup code to use phys_addr_t instead of assuming
>> 32-bit addressing.  Without this we cannot boot on systems where initrd is
>> located above the 4G physical address limit.
>
> The description needs updating.  You're no longer using phys_addr_t for the
> initrd size.
>

Thanks.  Nico had pointed this out earlier.  I've fixed for v4.

Thanks
-- Cyril.
