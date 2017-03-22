From: briannorris@chromium.org (Brian Norris)
Date: Wed, 22 Mar 2017 10:56:37 -0700
Subject: [PATCH v3 1/4] dt-bindings: Document rk3399 Gru/Kevin
In-Reply-To: <3700058.o6cBinDvsr@phil>
References: <20170320235344.126298-1-briannorris@chromium.org>
 <20170320235344.126298-2-briannorris@chromium.org>
 <3700058.o6cBinDvsr@phil>
Message-ID: <20170322175636.GA98450@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 10:01:00AM +0100, Heiko Stuebner wrote:
> Am Montag, 20. M?rz 2017, 16:53:41 CET schrieb Brian Norris:
> > Gru is a base dev board for a family of devices, including Kevin. Both
> > utilize Rockchip RK3399, and they share much of their design.
> > 
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > Acked-by: Rob Herring <robh@kernel.org>
> 
> applied for 4.12, after adding a "(Samsung Chromebook Plus)" hint, as that may 
> help people identifying the correct dts and also is public knowledge (some 
> blogs but also /proc/device-tree/compatible on the device itself).

Oh, thanks. There wasn't a public name when I first started sending this
series :)

Brian
