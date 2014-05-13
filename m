From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Tue, 13 May 2014 20:24:13 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAzLzNdIEFSTTogaS5NWDEgY2xrOiBBZGQgZGV2aWNl?=
 =?UTF-8?B?dHJlZSBzdXBwb3J0?=
In-Reply-To: <CAOMZO5Br9wpZu06oP3-Ax5XG=u+A6Ydq9peKet64Kw_moGgRaw@mail.gmail.com>
References: <1399997116-4313-1-git-send-email-shc_work@mail.ru>
 <CAOMZO5Br9wpZu06oP3-Ax5XG=u+A6Ydq9peKet64Kw_moGgRaw@mail.gmail.com>
Message-ID: <1399998253.839894262@f391.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tue, 13 May 2014 13:18:40 -0300 ?? Fabio Estevam <festevam@gmail.com>:
> On Tue, May 13, 2014 at 1:05 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
> 
> > +       clk[IMX1_CLK_DUMMY] =
> > +               imx_clk_fixed("dummy", 0);
> > +       clk[IMX1_CLK_CLK32] =
> > +               imx_obtain_fixed_clock("clk32", fref);
> > +       clk[IMX1_CLK_CLK16M_EXT] =
> > +               imx_clk_fixed("clk16m_ext", 16000000);
> > +       clk[IMX1_CLK_CLK16M] =
> > +               imx_clk_gate("clk16m", "clk16m_ext", CCM_CSCR, 17);
> 
> Why don't you put each entry into a single line instead?
> 
> Even if it gets larger than 80 columns, it would be easier to read.

I thought about it, but came to the conclusion that it is better to observe
the kernel rules.

---
