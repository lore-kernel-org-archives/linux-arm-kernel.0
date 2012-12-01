From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 1 Dec 2012 22:49:38 +0900
Subject: [PATCH 1/2] ASoC: Samsung: WM8994: Add basic device tree support
 for machine file
In-Reply-To: <1354356447-16784-2-git-send-email-padma.v@samsung.com>
References: <1354356447-16784-1-git-send-email-padma.v@samsung.com>
 <1354356447-16784-2-git-send-email-padma.v@samsung.com>
Message-ID: <20121201134937.GD17981@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 01, 2012 at 03:37:26PM +0530, Padmavathi Venna wrote:
> Add the basic device tree based lookup.
> 
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> ---
>  sound/soc/samsung/smdk_wm8994.c |   23 +++++++++++++++++++++++

Any new device tree bindings need binding documentation.

Your subject line is also very misleading here...  it should say that
it's talking about the SMDK.  There's at least two other WM8994 based
Samsung boards in mainline.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121201/b82b780b/attachment.sig>
