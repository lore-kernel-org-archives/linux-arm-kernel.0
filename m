From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 Jun 2018 13:07:33 +0100
Subject: [PATCH v8 2/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <CAD=FV=XVEEPgjBXxR+-46RgxLOq63Xvq-jtruoaCxccmMoKUuA@mail.gmail.com>
References: <cover.1529712888.git.collinsd@codeaurora.org>
 <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
 <CAD=FV=XVEEPgjBXxR+-46RgxLOq63Xvq-jtruoaCxccmMoKUuA@mail.gmail.com>
Message-ID: <20180626120733.GD1779@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 11:50:52AM -0700, Doug Anderson wrote:

> ...to this patch.  Speaking of which it might be getting very close to
> time for this series to land along with David's other series, AKA:

> * [1/2] regulator: of: add property for allowed modes specification
>   https://patchwork.kernel.org/patch/10395731/

> * [2/2] regulator: of: add support for allowed modes configuration
>   https://patchwork.kernel.org/patch/10395725/

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180626/756ecee7/attachment-0001.sig>
