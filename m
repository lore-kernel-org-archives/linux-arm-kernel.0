From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 22 Mar 2012 18:44:15 +0000
Subject: [PATCH 4/4] clk: wm831x: Add initial WM831x clock driver
In-Reply-To: <CAJOA=zOYfwy-smo6ukX7GSE2jrwz4UxwpgcFJiW876ga7ksShw@mail.gmail.com>
References: <1332360082-25092-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1332360082-25092-4-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120321222622.GG29317@pengutronix.de>
 <20120322111531.GA3091@opensource.wolfsonmicro.com>
 <20120322112613.GA3852@pengutronix.de>
 <20120322113356.GC3091@opensource.wolfsonmicro.com>
 <CAJOA=zOYfwy-smo6ukX7GSE2jrwz4UxwpgcFJiW876ga7ksShw@mail.gmail.com>
Message-ID: <20120322184415.GA3291@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 22, 2012 at 11:35:29AM -0700, Turquette, Mike wrote:

> I'm happy for the core to concatenate the strings when a struct device
> *dev is passed in.  However the reason I dropped this in the first
> place is that I have some ideas on providing something like clk_get
> directly from the common clk core and I hadn't figured out all of the
> details yet.  For now we can handle the string concatenation in the
> core and figure out those tricky details if/when the time comes to
> provide a clk_get which is more closely linked to the clock framework
> implementation.

Yeah, it's that sort of feature that most pushes against doing it in the
drivers - for example, the regulator API never ends up doing anything
like the concatenation.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120322/cdebbec9/attachment.sig>
