From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 24 Apr 2012 13:52:02 +0200
Subject: [PATCH V3 03/12] i2c/i2c-pxa: Remove conditional compilation of
 clk code
In-Reply-To: <08a0a53dde1958a395a9950d5e910bcb6e3b02b6.1335266056.git.viresh.kumar@st.com>
References: <cover.1335266056.git.viresh.kumar@st.com>
 <08a0a53dde1958a395a9950d5e910bcb6e3b02b6.1335266056.git.viresh.kumar@st.com>
Message-ID: <20120424115202.GB4030@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 04:51:25PM +0530, Viresh Kumar wrote:
> From: Viresh Kumar <viresh.linux@gmail.com>
> 
> With addition of dummy clk_*() calls for non CONFIG_HAVE_CLK cases in clk.h,
> there is no need to have clk code enclosed in #ifdef CONFIG_HAVE_CLK, #endif
> macros.
> 
> pxa i2c also has these dummy macros defined locally. Remove them as they aren't
> required anymore.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: linux-i2c at vger.kernel.org

Shall probably not go in via I2C-tree, so:

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120424/e1afffa4/attachment.sig>
