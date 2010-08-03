From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Tue, 3 Aug 2010 13:19:00 -0700 (PDT)
Subject: concurrent access to gpiolib on mxc.
In-Reply-To: <4C58643E.2040105@xenomai.org>
Message-ID: <602293.37535.qm@web51008.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gilles,

--- On Tue, 8/3/10, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:

> From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> Subject: concurrent access to gpiolib on mxc.
> To: "Sascha Hauer" <s.hauer@pengutronix.de>
> Cc: "ARM Linux Mailing List" <linux-arm-kernel@lists.infradead.org>
> Date: Tuesday, August 3, 2010, 3:47 PM
> 
> Hi Sascha,
> 
> the gpiolib support on mxc seems to lack protection against
> concurrent
> access. Is it OK for this SOC family?

See this patch that is now on Sascha's tree: http://git.pengutronix.de/?p=imx/linux-2.6.git;a=commit;h=8de841dc03c0bd0841f99923dc1b6cc55c33361d

Regards,

Fabio Estevam



      
