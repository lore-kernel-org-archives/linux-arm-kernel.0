From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 18 Jun 2014 14:31:36 -0300
Subject: [PATCH 1/2] ARM: i.MX: Migrate Freescale i.MX27 IP Camera board
 to devicetree
In-Reply-To: <1403112350.754983078@f438.i.mail.ru>
References: <1402642578-2456-1-git-send-email-shc_work@mail.ru>
 <1402672866.272590114@f160.i.mail.ru>
 <20140618143135.GO8860@dragon>
 <1403112350.754983078@f438.i.mail.ru>
Message-ID: <CAOMZO5DREU6FJCGX30ufwGxddDypVxai_JwM4PybiGU=-86OVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 2:25 PM, Alexander Shiyan <shc_work@mail.ru> wrote:

> OK. What about mach-imx27lite (Part 2/2 of this patch)?

I would suggest simply removing the board support for mach-imx27lite too.

This board only has UART and FEC support and there have been no more
updates to add new features since the initial commit.

If anyone is interested on this board, then it should be simple to add
a dts file for it.
