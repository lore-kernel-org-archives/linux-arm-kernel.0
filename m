From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 17 Jul 2012 14:35:51 +0100
Subject: linux-next: manual merge of the arm-soc tree with the
 i2c-embedded tree
In-Reply-To: <500568D9.10805@linaro.org>
References: <5003FB7C.4030509@linaro.org>
 <20120717130650.GB27595@sirena.org.uk> <500568D9.10805@linaro.org>
Message-ID: <20120717133550.GC4477@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 02:30:01PM +0100, Lee Jones wrote:
> On 17/07/12 14:06, Mark Brown wrote:

> >It's not just about having generic bindings, it's also about having
> >bindings which have some abstraction and hope of reusability. An awful
> >lot of bindings are just straight dumps of Linux data structures into
> >the device tree which don't make a terribly great deal of sense as
> >bindings.

> The Device Tree should supply any platform configuration which the
> driver needs in order to correctly setup for a particular machine.
> This is exactly what the platform_data structure did before, hence
> is is reasonable to assume that whatever information resides in that
> structure would be required in the Device Tree.

An *awful* lot of what people are trying to put into platform data is
nothing to do with that, it's just the generic data the driver needs to
be able to understand the hardware at all.  Things like the MFD
breakdown, random parameters of the hardware which you can infer from
the device name and so on.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120717/2354dfe5/attachment.sig>
