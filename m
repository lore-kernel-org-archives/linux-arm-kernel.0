From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 5 Jul 2012 15:51:27 +0200
Subject: [PATCH] gpio/mxc: use the edge_sel feature if available
In-Reply-To: <20120627065949.GC1623@pengutronix.de>
References: <Pine.LNX.4.64.1206221540390.17552@axis700.grange>
 <1463885754.3196304.1340391846559.JavaMail.root@advansee.com>
 <20120627065949.GC1623@pengutronix.de>
Message-ID: <CACRpkdb2Mkvc3-FDhED3foQAm8kymZavSURsgVVNn_=6sBMBFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2012 at 8:59 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Fri, Jun 22, 2012 at 09:04:06PM +0200, Beno?t Th?baudeau wrote:

>> [PATCH] gpio/mxc: use the edge_sel feature if available
>>
>> Some mxc processors have an edge_sel feature, which allows the IRQ to be
>> triggered by any edge.
>>
>> This patch makes use of this feature if available, which skips mxc_flip_edge().
>>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Linus Walleij <linus.walleij@stericsson.com>
>> Cc: Sascha Hauer <kernel@pengutronix.de>
>> Cc: <linux-arm-kernel@lists.infradead.org>
>> Signed-off-by: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>
>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
>
> Grant, Linus, this should probably go through your gpio tree.

OK applied.

Make sure to check in linux-next that I got it right.

Yours,
Linus Walleij
