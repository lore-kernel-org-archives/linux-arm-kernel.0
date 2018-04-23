From: broonie@kernel.org (Mark Brown)
Date: Mon, 23 Apr 2018 12:50:43 +0100
Subject: [PATCH v2 1/2] regmap: include <linux/ktime.h> from
 include/linux/regmap.h
In-Reply-To: <d3e10dc5-55d3-40b8-a8de-d48aaaecf019@gmail.com>
References: <ccea364eeb830b2092987d271c8308b97fe59d8f.1524465345.git.sean.wang@mediatek.com>
 <20180423100318.GA19834@sirena.org.uk>
 <d3e10dc5-55d3-40b8-a8de-d48aaaecf019@gmail.com>
Message-ID: <20180423115043.GD19834@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2018 at 12:11:01PM +0200, Matthias Brugger wrote:

> On 04/23/2018 12:03 PM, Mark Brown wrote:
> > On Mon, Apr 23, 2018 at 02:42:44PM +0800, sean.wang at mediatek.com wrote:
> >> From: Sean Wang <sean.wang@mediatek.com>

> >> Similar to the readx_poll_timeout() macro calling ktime_* and using 
> >> ktime_t type, which is declared in <linux/ktime.h>. So, make

> > I'm missing patch 2 here - what's the story, are there any dependencies?

> You can find the second patch here:
> https://patchwork.kernel.org/patch/10356237/

So it looks like there is a dependency here...?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180423/7fc3ebb6/attachment.sig>
