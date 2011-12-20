From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 20 Dec 2011 21:11:33 +0800
Subject: [PATCH v4] I2C: add CSR SiRFprimaII on-chip I2C controllers driver
In-Reply-To: <1323852927-13521-1-git-send-email-Barry.Song@csr.com>
References: <1323852927-13521-1-git-send-email-Barry.Song@csr.com>
Message-ID: <CAGsJ_4yL2tk-W3jL2E9BpiLE7utv2ytf5E8wisw0O-B8uMh-MA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/12/14 Barry Song <Barry.Song@csr.com>:
> From: Zhiwu Song <Zhiwu.Song@csr.com>
>
> SiRFprimaII is the latest generation application processor from CSR?s
> multi-function SoC product family.
> The SoC support codes are in arch/arm/mach-prima2 from Linux mainline
> 3.0.
> There are two I2C controllers on primaII, features include:
> * Two I2C controller modules are on chip
> * RISC I/O bus read write register
> * Up to 16 bytes data buffer for issuing commands and writing data
> ?at the same time
> * Up to 16 commands, and receiving read data 16 bytes at a time
> * Error INT report (ACK check)
> * No-ACK bus protocols (SCCB bus protocols)
>
> Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
> Signed-off-by: Xiangzhen Ye <Xiangzhen.Ye@csr.com>
> Signed-off-by: Yuping Luo <Yuping.Luo@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
> ?-v4:
> ?fix some minor issues pointed out by Shubhrajyoti Datta;
> ?move platform_driver.suspend/resume to dev_pm_ops;
> ?use Wolfram Sang's new devm_request_and_ioremap() api, refer to:
> ? ? https://lkml.org/lkml/2011/10/25/226

Hi Ben,
can we do something to move things ahead? the patch has sent for
several weeks and 4 versions based on feedback from other people, you
haven't given any comment, nack or ack. Are you still active, or are
you just too busy to take care?
Thanks
barry
