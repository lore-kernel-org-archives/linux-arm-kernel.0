From: cjb@laptop.org (Chris Ball)
Date: Thu, 08 Mar 2012 23:53:35 -0500
Subject: [PATCH v2 0/6] mmc: omap_hsmmc: Clean up use/abuse of pdev->id
In-Reply-To: <4F589C94.9010601@ti.com> (Rajendra Nayak's message of "Thu, 08
 Mar 2012 17:18:36 +0530")
References: <1329996409-26861-1-git-send-email-rnayak@ti.com>
 <4F476228.7060607@ti.com> <4F54714E.6080805@ti.com>
 <4F57312E.4080104@ti.com> <m2pqcoihhu.fsf@bob.laptop.org>
 <4F589C94.9010601@ti.com>
Message-ID: <m2boo6pe7k.fsf@bob.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 08 2012, Rajendra Nayak wrote:
> There's just one other cleanup patch here [1] to convert all pr_* prints
> in the driver to dev_*. Would be great if you can pick that as well.
>
> Thanks,
> Rajendra
>
> [1] http://marc.info/?l=linux-mmc&m=132999677405098&w=3

Thanks, I've pushed this to mmc-next for 3.4 now too.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
