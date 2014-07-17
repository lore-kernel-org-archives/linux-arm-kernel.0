From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 17 Jul 2014 15:40:00 +0200
Subject: [PATCH v2] i2c: efm32: correct namespacing of location property
In-Reply-To: <1405068614-14279-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1405066940-12919-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1405068614-14279-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20140717134000.GK2740@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 10:50:14AM +0200, Uwe Kleine-K?nig wrote:
> Olof Johansson pointed out that usually the company name is picked as
> namespace prefix to specific properties. So expect "energymicro,location"
> but fall back to the previously introduced name "efm32,location".
> 
> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Applied to for-next, thanks! If you think this is better suited in
for-current, let me know.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/8d55127a/attachment.sig>
