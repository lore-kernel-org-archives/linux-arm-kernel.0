From: broonie@kernel.org (Mark Brown)
Date: Mon, 26 Aug 2013 20:56:32 +0100
Subject: [ARM ATTEND] catching up on exploit mitigations
In-Reply-To: <5209BB6F.2000208@codeaurora.org>
References: <CAGXu5jKv9Vt+Hu0mFYaxggLLDZ46U3KR9MKegUoHH8StXCkBtQ@mail.gmail.com>
 <5209BB6F.2000208@codeaurora.org>
Message-ID: <20130826195632.GG10783@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 09:51:59PM -0700, Laura Abbott wrote:
> On 7/30/2013 12:05 PM, Kees Cook wrote:

> >- RO and W^X kernel page table protections (similar to x86's
> >DEBUG_RODATA and DEBUG_SET_MODULE_RONX; it's not clear to me how much
> >LPAE and PXN is already handling this, if at all)

> We've had support for RO/NX on our tree for a while. I'm interested
> in attending the summit to share what we've done and to see how much
> of it could be mainlined.

Is that related to the code that Google have in their tree?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130826/124e3c20/attachment.sig>
