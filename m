From: cjb@laptop.org (Chris Ball)
Date: Wed, 21 Sep 2011 08:18:34 -0400
Subject: [PATCH v2 1/2] mmc: sdhci-s3c: add default controller
	configuration
In-Reply-To: <002501cc784d$1618f110$424ad330$%kim@samsung.com> (Kukjin Kim's
	message of "Wed, 21 Sep 2011 19:56:16 +0900")
References: <1315984158-29651-1-git-send-email-thomas.abraham@linaro.org>
	<1315984158-29651-2-git-send-email-thomas.abraham@linaro.org>
	<002501cc784d$1618f110$424ad330$%kim@samsung.com>
Message-ID: <m2boue6qcl.fsf@bob.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 21 2011, Kukjin Kim wrote:
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
>
> Hi Chris,
>
> This is ok to me. Could you please pick this up in your tree so that I can
> pick 2nd patch up in my tree.
>
> As you know, this patch has no dependency with patch2/2 so that you can
> handle without any conflicts.

Thanks, pushed to mmc-next for 3.2.

I've been waiting for kernel.org to come back up, but I think later
today I'll just move mmc-next to git://dev.laptop.org/users/cjb/mmc,
so this will be available in linux-next soon.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
