From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 4 Sep 2012 23:19:55 +1000
Subject: linux-next: manual merge of the arm-soc tree with the
 arm-current tree
In-Reply-To: <201209041311.02222.arnd@arndb.de>
References: <20120904160626.f1dcb67ebbb145053c49da8c@canb.auug.org.au>
 <20120904090132.GG24085@n2100.arm.linux.org.uk>
 <5045F7A0.1090400@gmail.com> <201209041311.02222.arnd@arndb.de>
Message-ID: <20120904231955.fb82c1b44e7c4568f626c915@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Sep 2012 13:11:02 +0000 Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tuesday 04 September 2012, Rob Herring wrote:
> > Right. The PCI i/o reserved area has a dummy physical address of 0 and 
> > needs to be skipped by ioremap searches. So we don't set 
> > VM_ARM_STATIC_MAPPING to prevent matches by ioremap. The vm_struct settings
> > don't really matter when we do the real mapping of the i/o space.
> > 
> > Here's my merge:
> 
> Ok, thanks for the clarification. I've merged Russell's fixes branch
> into the cleanup/io-pci branch now to resolve the conflict.

Even better than me handling it.  Thanks guys.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120904/d1fac2e9/attachment.sig>
