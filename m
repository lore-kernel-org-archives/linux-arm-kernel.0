From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 6 Jul 2012 11:01:11 +0200
Subject: [V3 2/4] mfd: 88pm860x: add pre-regulator device for 88pm860x
In-Reply-To: <1341543598-6477-1-git-send-email-jtzhou@marvell.com>
References: <20120705141541.GO4111@opensource.wolfsonmicro.com>
 <1341543598-6477-1-git-send-email-jtzhou@marvell.com>
Message-ID: <20120706090111.GA5413@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jett,

On Fri, Jul 06, 2012 at 10:59:58AM +0800, Jett.Zhou wrote:
> Pre-regulator of 88pm8606 is mainly for support charging based on vbus,
> it needs to be enabled for charging battery, and will be disabled in
> some exception condition like over-temp.
> Add the pre-regulator device init data and resource for mfd subdev.
> 
> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> ---
>  drivers/mfd/88pm860x-core.c  |   23 +++++++++++++++++++++++
>  include/linux/mfd/88pm860x.h |    1 +
>  2 files changed, 24 insertions(+), 0 deletions(-)
Applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
