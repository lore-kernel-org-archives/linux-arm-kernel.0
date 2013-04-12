From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 12 Apr 2013 10:38:24 -0300
Subject: [PATCH v3 1/1 net-next] net: fec: put tx to napi poll function to
 fix dead lock
In-Reply-To: <20130324143525.GI6281@S2101-09.ap.freescale.net>
References: <1362368065-5809-1-git-send-email-Frank.Li@freescale.com>
 <20130320114824.GA6088@S2101-09.ap.freescale.net>
 <CAOMZO5B-ipzyb2uiLW12fFd3PD3JfLS8R0YLM5vtLgFNz8abUw@mail.gmail.com>
 <20130324143525.GI6281@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5C9ZX_SygEdMdcGXbH8=gLKn0igOMkZ8vGP3HNzD+fvxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 24, 2013 at 11:35 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> Are you sure?  After reverting the patch on next-20130322, I can get
> imx28 resume back to console as below.

Yes, please try 20130412, which has Frank's fix applied and try
suspend/resume sequence several times.

Does it work always for you?

On my mx28evk it usually fails.
