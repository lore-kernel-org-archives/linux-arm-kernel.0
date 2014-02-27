From: blibbet@gmail.com (Blibbet)
Date: Wed, 26 Feb 2014 16:41:21 -0800
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <20140226183454.GA14639@cbox>
References: <20140226183454.GA14639@cbox>
Message-ID: <530E89B1.90604@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/26/14 10:34 AM, Christoffer Dall wrote:
> ARM VM System Specification
> ===========================

See also the thread forked off to the EFI dev list, about using existing 
EFI ByteCode (EBC) for this new purpose, especially the informative 
reply from Andrew Fish of Apple.com:

http://sourceforge.net/p/edk2/mailman/message/32031943/

Today, EBC is created by Intel, and targets Intel's 3 platforms, but no 
ARM platforms yet. Today existing EFI uses EBC "VM", existing 
implementation exists with BSD license. EBC's goal was to let IHVs share 
Option ROM style drivers, not have to ship multiple ones. Having ARM and 
Intel use the same VM/bytecode would be even better for IHVs. I'm 
unclear to your non-EFI use cases, so may not be useful outside EFI. IMO 
the main issue with EBC is only commercial Intel and Microsoft compilers 
support it, not GCC or CLang. IP clarify of this Intel creation would 
also be an issue, but apparently UEFI Forum owns the spec.

There are too many lists CC'ed already, but if this becomes a valid 
option, the linux-efi list on kernel.org needs to get invited. :-)

Thanks,
Lee
