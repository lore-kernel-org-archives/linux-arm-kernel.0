From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Jan 2012 10:20:22 +0800
Subject: [GIT PULL] mxs: board support for 3.3
In-Reply-To: <20120108034408.GB19721@S2101-09.ap.freescale.net>
References: <20120108034408.GB19721@S2101-09.ap.freescale.net>
Message-ID: <20120109022020.GG1835@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 08, 2012 at 11:44:10AM +0800, Shawn Guo wrote:
> Hi Arnd, Olof,
> 
> As I promised to Lauri, I will send his board support for 3.3.  I know
> even if it gets pulled, it will go to 'late/*' which is not guaranteed
> to be sent for 3.3.  But anyway, here it is.  Please consider to pull.
> 
I forgot to mention that it has a dependency on arm-soc/mxs/saif.  But
since it will go to late/* and the mxs/saif already hits next/*, the
dependency can be sorted out easily, I guess.

-- 
Regards,
Shawn
