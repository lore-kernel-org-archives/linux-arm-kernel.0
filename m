From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 4 Apr 2017 15:21:57 +0200
Subject: [PATCH v2] dt-bindings: Add documentation for GP10B GPU
In-Reply-To: <20170330092644.11890-1-acourbot@nvidia.com>
References: <20170330091831.18322-2-acourbot@nvidia.com>
 <20170330092644.11890-1-acourbot@nvidia.com>
Message-ID: <20170404132157.GA843@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 06:26:44PM +0900, Alexandre Courbot wrote:
> GP10B's definition is mostly similar to GK20A's and GM20B's. The only
> noticeable difference is the use of power domains instead of a regulator
> for power supply.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> Changes since v1:
> - It's much better when it compiles.
> 
>  .../devicetree/bindings/gpu/nvidia,gk20a.txt       | 25 +++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)

Applied to for-4.12/arm64/dt, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170404/31c96b9a/attachment-0001.sig>
