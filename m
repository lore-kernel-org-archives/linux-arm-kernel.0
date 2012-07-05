From: sameo@linux.intel.com (Samuel Ortiz)
Date: Thu, 5 Jul 2012 16:24:31 +0200
Subject: [V3 1/3] regulator: add pre-regulator support for 88pm860x
In-Reply-To: <1340278283-16423-1-git-send-email-jtzhou@marvell.com>
References: <20120621101536.GR4037@opensource.wolfsonmicro.com>
 <1340278283-16423-1-git-send-email-jtzhou@marvell.com>
Message-ID: <20120705142431.GD18200@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jett,

On Thu, Jun 21, 2012 at 07:31:23PM +0800, Jett.Zhou wrote:
> Pre-regulator of 88pm8606 is mainly for support charging based on vbus,
> it needs to be enabled for charging battery, and will be disabled in
> some exception condition like over-temp.
> 
> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> ---
>  drivers/mfd/88pm860x-core.c  |   23 ++++++++++++++
>  drivers/regulator/88pm8607.c |   66 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/88pm860x.h |    1 +
>  3 files changed, 90 insertions(+), 0 deletions(-)
Unless Mark already applied this patch, could you please split it into and MFD
and a regulator (separate) patches ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
