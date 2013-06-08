From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 8 Jun 2013 14:23:08 +0800
Subject: [PATCH V2] serial: imx: enable the clocks only when the uart is
 used
In-Reply-To: <51B2CDAF.3050104@freescale.com>
References: <1370311173-15019-1-git-send-email-b32955@freescale.com>
 <20130608060116.GB20780@S2101-09.ap.freescale.net>
 <51B2CDAF.3050104@freescale.com>
Message-ID: <20130608062307.GB22416@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 08, 2013 at 02:22:39PM +0800, Huang Shijie wrote:
> ? 2013?06?08? 14:01, Shawn Guo ??:
> >Running linux-next 20130607, I just found that the serial console stops
> >working due to this patch.  I think the clocks need to be enabled for
> >console as well.
> could you tell me the board?
> i tested on imx6q-sabreauto boards, the console is ok.

imx6q-sabresd

Shawn
