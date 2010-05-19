From: horms@verge.net.au (Simon Horman)
Date: Wed, 19 May 2010 09:47:14 +0900
Subject: [PATCH v2 0/2] kexec-tools: ARM kernel crashdump support
In-Reply-To: <cover.1273041787.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1273041787.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <20100519004714.GK8536@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 05, 2010 at 09:58:31AM +0300, Mika Westerberg wrote:
> Hello,
> 
> These patches bring ARM kernel crashdump support for kexec-tools. Only zImage
> format is currently supported.
> 
> Changes to v1:
> 	- removed virtual address calculation based on phys_offset and moved
> 	  this to a separate function (phys_to_virt()) which can then be
> 	  redefined by archs if needed.
> 	- ARM version redefines this function and uses phys_offset for
> 	  calculating virtual addresses for kernel direct mapped region.
> 
> In addition, I have modified sample gdb macros from
> kernel/Documentation/kdump/gdbmacrox.txt to work with ARM crashdumps. They are
> included in the end of this email in case someone finds them useful.

Thanks, both patches applied.
