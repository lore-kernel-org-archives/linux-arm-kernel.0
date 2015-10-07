From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Wed, 7 Oct 2015 13:30:07 -0700
Subject: [PATCH] ARM: configs: keystone: Add ramdisk support
In-Reply-To: <12772658.mmM2ZKnfR4@wuerfel>
References: <1444246089-1417-1-git-send-email-nm@ti.com>
 <12772658.mmM2ZKnfR4@wuerfel>
Message-ID: <561580CF.9090504@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/7/2015 12:37 PM, Arnd Bergmann wrote:
> On Wednesday 07 October 2015 14:28:09 Nishanth Menon wrote:
>> Add ramdisk support to allow for minimal kernel to be supported.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>
>
> I have not seen that in a while. Can you explain why the normal
> initramfs method doesn't work on keystone?
>
It should work. It has been while I tried it, but IIRC, it use
to work. At least can't recollect any issue around it.

Regards,
Santosh
