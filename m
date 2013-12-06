From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 6 Dec 2013 15:26:05 +0100
Subject: [PATCH v5 1/3] mfd: tps6586x: add version detection
In-Reply-To: <7812fb79beac0a6a409090f43d129893f9f93b5b.1386333697.git.stefan@agner.ch>
References: <cover.1386333697.git.stefan@agner.ch>
 <7812fb79beac0a6a409090f43d129893f9f93b5b.1386333697.git.stefan@agner.ch>
Message-ID: <20131206142605.GA32363@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 06, 2013 at 01:51:45PM +0100, Stefan Agner wrote:
> Use the VERSIONCRC to determine the exact device version. According to
> the datasheet this register can be used as device identifier. The
> identification is needed since some tps6586x regulators use a different
> voltage table.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Changes since v4:
>   - Use variable named version instead of ret
> 
> Changes since v2:
>   - Avoid moving devm_kzalloc
> ---
>  drivers/mfd/tps6586x.c       | 50 +++++++++++++++++++++++++++++++++++++-------
>  include/linux/mfd/tps6586x.h |  7 +++++++
>  2 files changed, 49 insertions(+), 8 deletions(-)

I think I also already gave my Reviewed-by on both this and 2/3, neither
of which changed significantly enough to warrant that to be dropped. In
general it's fine to keep Reviewed-by and Acked-by as long as you're
only changing minor things.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131206/d8a623c3/attachment.sig>
