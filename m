From: b-liu@ti.com (Bin Liu)
Date: Wed, 21 Sep 2016 15:51:33 -0500
Subject: [PATCH v2] musb: Export musb_root_disconnect for use in modules
In-Reply-To: <20160917100810.2406-1-hdegoede@redhat.com>
References: <20160917100810.2406-1-hdegoede@redhat.com>
Message-ID: <20160921205133.GC3981@uda0271908>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Sep 17, 2016 at 12:08:10PM +0200, Hans de Goede wrote:
> Export musb_root_disconnect for use in modules, so that musb glue
> code build as module can use it.
> 
> This fixes the buildbot errors for -next in arm64-allmodconfig
> and arm-allmodconfig.
> 
> Fixes: 7cba17ec9adc8cf ("musb: sunxi: Add support for platform_set_mode")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied. Thanks.

Regards,
-Bin.
