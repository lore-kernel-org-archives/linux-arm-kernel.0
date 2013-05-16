From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 16 May 2013 20:22:19 +0800
Subject: [PATCH 08/33] drivers/i2c/busses: don't check resource with
 devm_ioremap_resource
In-Reply-To: <1368702961-4325-9-git-send-email-wsa@the-dreams.de>
References: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>
 <1368702961-4325-9-git-send-email-wsa@the-dreams.de>
Message-ID: <CAGsJ_4zAJpqxjg_rcO1WxS=GLii7YooPnsCgt40frf_5afiY6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/5/16 Wolfram Sang <wsa@the-dreams.de>:
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Barry Song <Baohua.Song@csr.com>

-barry
