From: dwmw2@infradead.org (David Woodhouse)
Date: Tue, 10 Aug 2010 08:54:21 +0100
Subject: kernel2.6.34.1 headers_install did not make asm
In-Reply-To: <AANLkTi=E9nYU8nV2LiaaS2tENYThqb42rasDoohMKaC=@mail.gmail.com>
References: <AANLkTi=E9nYU8nV2LiaaS2tENYThqb42rasDoohMKaC=@mail.gmail.com>
Message-ID: <1281426861.7143.60.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-08-10 at 16:50 +0900, takanobu watanabe wrote:
> 
> tknv at Lenny55G:~/src/kernel-2.6.34/linux-2.6.34.1$ ls include/
> acpi         crypto     Kbuild  math-emu  net     rxrpc  trace
> asm-generic  drm        keys    media     pcmcia  scsi   video
> config       generated  linux   mtd       rdma    sound  xen 

ls usr/include/

Or use 'make INSTALL_HDR_PATH=/somewhere/else' if you want to put the
resulting headers elsewhere.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
