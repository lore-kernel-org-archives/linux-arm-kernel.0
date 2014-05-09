From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 9 May 2014 00:11:32 -0300
Subject: [PATCH] ARM i.MX51: Add Efika MX Smartbook devicetree
In-Reply-To: <20140508062616.GF5918@pengutronix.de>
References: <1397641298-25392-1-git-send-email-shc_work@mail.ru>
 <20140508062616.GF5918@pengutronix.de>
Message-ID: <CAOMZO5AbKxzre0vMNcAyk5u2Cmwt8fbiAUSgqVpiLkuigvXzpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 8, 2014 at 3:26 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> From what I can see ulpi mode is not supported currently in the chipidea
> driver. I think that shouldn't block adding these device nodes, but

It works with usb nop transceiver. We got it running on mx27pdk,
mx51evk and other boards.
