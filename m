From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 5 Apr 2012 15:12:49 +0200
Subject: Query: clk: Defining new struct clk_foo types
In-Reply-To: <4F7D76A8.3080904@st.com>
References: <4F7D443E.3010800@st.com> <20120405095835.GB20478@pengutronix.de>
 <4F7D705D.7050004@st.com> <20120405103039.GC3852@pengutronix.de>
 <4F7D76A8.3080904@st.com>
Message-ID: <20120405131249.GD3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2012 at 04:10:40PM +0530, Viresh Kumar wrote:
> On 4/5/2012 4:00 PM, Sascha Hauer wrote:
> > Besides, I don't  recommend using the DEFINE_CLK_* macros. You should
> > really consider using clk_register_* instead.
> 
> Can you point me to some users of this clock framework, with such
> runtime stuff? That would be really helpful.

See this branch:

git://git.pengutronix.de/git/imx/linux-2.6.git work/v3.4-rc1-imx-clk

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
