From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 06 Nov 2017 10:45:51 +0100
Subject: [PATCH] clk: meson: gxbb: fix wrong clock for SARADC/SANA
In-Reply-To: <9b1f5cb5-9029-8865-a867-54d819b42e1a@amlogic.com>
References: <20171106075212.14275-1-yixun.lan@amlogic.com>
 <1509959454.1328.8.camel@baylibre.com>
 <9b1f5cb5-9029-8865-a867-54d819b42e1a@amlogic.com>
Message-ID: <1509961551.1328.13.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-11-06 at 17:38 +0800, Yixun Lan wrote:
> > * Is it an error in the published datasheets ?
> 
> then, I think the published datasheet need to be updated.

This needs to be clearly explained in your patch description/comment, or maybe
directly in the code.
