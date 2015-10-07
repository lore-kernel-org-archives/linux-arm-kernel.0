From: nm@ti.com (Nishanth Menon)
Date: Wed, 7 Oct 2015 14:56:32 -0500
Subject: [PATCH] ARM: configs: keystone: Add ramdisk support
In-Reply-To: <12772658.mmM2ZKnfR4@wuerfel>
References: <1444246089-1417-1-git-send-email-nm@ti.com>
 <12772658.mmM2ZKnfR4@wuerfel>
Message-ID: <561578F0.80809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2015 02:37 PM, Arnd Bergmann wrote:
> On Wednesday 07 October 2015 14:28:09 Nishanth Menon wrote:
>> Add ramdisk support to allow for minimal kernel to be supported.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>
> 
> I have not seen that in a while. Can you explain why the normal
> initramfs method doesn't work on keystone?

It probably does - I have'nt used it - i am using an initrd thanks to
legacy testing support framework I am stuck with. The SoC I am
attempting to bring up has no support (yet) for any storage device for
filesystem yet.


-- 
Regards,
Nishanth Menon
