From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Fri, 2 Nov 2012 13:11:50 +0000
Subject: [PATCH 15/15] ARM: OMAP2+: AM33XX: Basic suspend resume support
In-Reply-To: <1351859566-24818-16-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-16-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBFD849@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 02, 2012 at 18:02:46, Bedia, Vaibhav wrote:
[...]
> +int wkup_mbox_msg(struct notifier_block *self, unsigned long len, void *msg)
> +{
> +	return 0;
> +}

This should have been static. Will change in the next version.
