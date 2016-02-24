From: broonie@kernel.org (Mark Brown)
Date: Wed, 24 Feb 2016 12:28:42 +0900
Subject: next-20160222 build: 5 failures 9 warnings (next-20160222)
In-Reply-To: <56CAE5E6.7030707@arm.com>
References: <E1aXlz4-000486-Pb@optimist> <20160222100832.GX18327@sirena.org.uk>
 <56CAE5E6.7030707@arm.com>
Message-ID: <20160224032842.GK18327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 10:41:42AM +0000, Marc Zyngier wrote:
> On 22/02/16 10:08, Mark Brown wrote:
> > On Mon, Feb 22, 2016 at 08:36:46AM +0000, Build bot for Mark Brown wrote:

> > Today's -next fails to build on arm64 due to:

> >> 	arm64-allnoconfig
> >> ../arch/arm64/include/asm/kvm_host.h:338:2: error: implicit declaration of function 'kvm_call_hyp' [-Werror=implicit-function-declaration]

> I'm about to push the following patch on top of the KVM tree:

> This will create a new conflict, but will make the resolution 100% clear.

That didn't work out unfortunately, the error is still there today.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160224/d80a1d16/attachment.sig>
