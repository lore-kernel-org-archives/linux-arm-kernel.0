From: horms@verge.net.au (Simon Horman)
Date: Tue, 11 May 2010 12:28:50 +0900
Subject: [PATCH - kexec] arm: place initrd to safer place according to
	zImage length
In-Reply-To: <h2xf17812d71004221936s779a4585r8b458f7f2630f7b1@mail.gmail.com>
References: <h2xf17812d71004221936s779a4585r8b458f7f2630f7b1@mail.gmail.com>
Message-ID: <20100511032850.GH7649@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 23, 2010 at 10:36:44AM +0800, Eric Miao wrote:
> commit 4b6d55c7780dbf383c6b64e560d459d15a891006
> Author: Eric Miao <eric.miao@canonical.com>
> Date:   Fri Apr 23 10:19:43 2010 +0800
> 
>     arm: place initrd to safer place according to zImage length
> 
>     The original fixed address of 0x800000 may be overwritten after the
>     kernel is decompressed.  Assume a maximum decompression ratio of 4
>     and place initrd right after that, just to be safer.
> 
>     Signed-off-by: Eric Miao <eric.miao@canonical.com>

Thanks, applied.
