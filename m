From: tony@atomide.com (Tony Lindgren)
Date: Fri, 13 Oct 2017 10:08:09 -0700
Subject: [PATCH -next] ARM: OMAP2+: omap_device: fix error return code in
 omap_device_copy_resources()
In-Reply-To: <1507886965-156349-1-git-send-email-weiyongjun1@huawei.com>
References: <1507886965-156349-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <20171013170809.GN4394@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Wei Yongjun <weiyongjun1@huawei.com> [171013 02:26]:
> Fix to return error code -EINVAL from the irq_of_parse_and_map() error
> handling case instead of 0, as done elsewhere in this function.

Thanks applying into omap-for-v4.15/ti-sysc.

Regards,

Tony
