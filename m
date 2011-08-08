From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 8 Aug 2011 23:46:58 +0530
Subject: [PATCH 12/15] spi/s3c64xx: Add support DMA engine API
In-Reply-To: <201108081955.39626.heiko@sntech.de>
References: <1311744697-10264-1-git-send-email-boojin.kim@samsung.com>
	<1311744697-10264-13-git-send-email-boojin.kim@samsung.com>
	<CABb+yY3-d0xTO+s0cCPXPW8qGpTH5G2U+bp-0z4Se47eVvJ__w@mail.gmail.com>
	<201108081955.39626.heiko@sntech.de>
Message-ID: <CABb+yY08vGuvp4uVm3nd0FvFoXa04jmDOaQYcu324q7326a5Lw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 8, 2011 at 11:25 PM, Heiko St?bner <heiko@sntech.de> wrote:
> Am Montag 08 August 2011, 19:47:58 schrieb Jassi Brar:

>> Btw, this spi driver is for S3C64xx(with pl080) and S5P(with pl330)
>> series, both of which
>> have DMAENGINE drivers. May be it could be directly switched to using
>> those, rather than
>> via Samsung's wrapper driver.
>> Or am I overlooking something ?
> yep, at least the S3C2416/2450 HSSPI which should use this driver.

Seems you keep some patches private ;)  the spi driver isn't enabled
for 2416 in mainline.
