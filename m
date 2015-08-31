From: broonie@kernel.org (Mark Brown)
Date: Mon, 31 Aug 2015 11:31:59 +0100
Subject: [PATCH v2] spi: bitbang: Replace spinlock by mutex
In-Reply-To: <CANMq1KAOsyhT1w54dc1u6JRzUdrjo-RpCb7CQBD66OdrSyPh=w@mail.gmail.com>
References: <1439783574-5933-1-git-send-email-drinkcat@chromium.org>
 <CANMq1KAOsyhT1w54dc1u6JRzUdrjo-RpCb7CQBD66OdrSyPh=w@mail.gmail.com>
Message-ID: <20150831103159.GJ12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 31, 2015 at 03:54:13PM +0800, Nicolas Boichat wrote:
> On Mon, Aug 17, 2015 at 11:52 AM, Nicolas Boichat <drinkcat@chromium.org> wrote:

> Any update on this patch? It still applies on for-next but happy to
> resend if necessary (patchwork:
> https://patchwork.kernel.org/patch/7023091/).

Please don't send content free pings and please allow a reasonable
amount of time for review.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150831/6b015b8e/attachment.sig>
