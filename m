From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 31 Oct 2012 11:24:06 -0200
Subject: [PATCH v4 1/2] ARM: clk-imx27: Add missing clock for mx2-camera
In-Reply-To: <20121031131652.GM1641@pengutronix.de>
References: <1351598606-8485-1-git-send-email-fabio.estevam@freescale.com>
 <20121031095632.536d9362@infradead.org>
 <20121031131652.GM1641@pengutronix.de>
Message-ID: <CAOMZO5CLxM41LYoLmPbfzSTF85Zk4B5SqHeVbGU4WjEOXw0eyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Wed, Oct 31, 2012 at 11:16 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> Quoting yourself:
>
>> Forgot to comment: as patch 2 relies on this change, the better, IMHO, is
>> to send both via the same tree. If you decide to do so, please get arm
>> maintainer's ack, instead, and we can merge both via my tree.
>
> That's why Fabio resent these patches with my Ack. You are free to take
> these.

I have just realized that this patch (1/2) will not apply against
media tree because it does not have commit 27b76486a3 (media:
mx2_camera: remove cpu_is_xxx by using platform_device_id), which
changes from mx2_camera.0 to imx27-camera.0.

So it seems to be better to merge this via arm tree to avoid such conflict.

Regards,

Fabio Estevam
