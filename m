From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 9 Apr 2013 12:09:35 +0200
Subject: [PATCH] mfd: vexpress: Give the "leds-gpio" device a real parent
In-Reply-To: <1364991987-6598-1-git-send-email-pawel.moll@arm.com>
References: <1364991987-6598-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20130409100935.GS24058@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawel,

On Wed, Apr 03, 2013 at 01:26:27PM +0100, Pawel Moll wrote:
> The registration of the "leds-gpio" device was using
> "vexpress_sysreg_dev" as a parent before it was actually
> set to something different than NULL.
> 
> Trivial fix by reordering the code.
> 
> Reported-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  drivers/mfd/vexpress-sysreg.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
Applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
