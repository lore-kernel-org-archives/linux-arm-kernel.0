From: neil@brown.name (NeilBrown)
Date: Mon, 04 Jun 2018 10:13:58 +1000
Subject: [PATCH 0/7] staging: mt7621-pci: Fix coding style issues
In-Reply-To: <cover.1528040188.git.abdun.nihaal@gmail.com>
References: <cover.1528040188.git.abdun.nihaal@gmail.com>
Message-ID: <877enfqugp.fsf@notabene.neil.brown.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 03 2018, Abdun Nihaal wrote:

> This patchset fixes the following set of coding style 
> issues found using checkpatch.
>
> ERROR: space prohibited after that open parenthesis '('
> ERROR: trailing whitespace
> ERROR: space required before the open parenthesis '('
> ERROR: space required after that ',' (ctx:VxV)
> ERROR: spaces required around that '=' (ctx:VxW)
> ERROR: spaces required around that '==' (ctx:WxV)
> ERROR: that open brace { should be on the previous line

Hi,
 thanks for contributing these, how ever some of these issues have
 already been address (not all).  I think you must be working from an
 old try.
 When submitting patches to drives/staging, they should be based on
 the staging-next branch of
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git

 Also, I'd suggest leaving linux-arm-kernel and linux-mediatek off the
 cc list.  They are unlikely to be interested until the driver is ready
 to be moved out of drivers/staging.

Thanks,
NeilBrown


>
> Abdun Nihaal (7):
>   staging: mt7621-pci: Remove space after open parenthesis
>   staging: mt7621-pci: remove trailing whitespace
>   staging: mt7621-pci: add space before open parenthesis
>   staging: mt7621-pci: add space after comma symbol
>   staging: mt7621-pci: add spaces around equal symbol
>   staging: mt7621-pci: add space after '==' symbol
>   staging: mt7621-pci: fix coding style error
>
>  drivers/staging/mt7621-pci/pci-mt7621.c | 114 ++++++++++++------------
>  1 file changed, 56 insertions(+), 58 deletions(-)
>
> -- 
> 2.17.0
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180604/e81a42a0/attachment.sig>
