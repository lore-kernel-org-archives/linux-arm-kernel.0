From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 16 Jun 2012 10:01:45 +0800
Subject: [PATCH v3 2/2] serial: mxs-auart: Allow device tree probing
In-Reply-To: <201206151900.21740.marex@denx.de>
References: <1339774557-23588-1-git-send-email-fabio.estevam@freescale.com>
 <201206151816.55567.marex@denx.de>
 <CAOMZO5AFaWGEfEhVs1TVc0c_Wp6aB7FT5zKHEoiucLnuWGg8zA@mail.gmail.com>
 <201206151900.21740.marex@denx.de>
Message-ID: <20120616020143.GB29663@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 15, 2012 at 07:00:21PM +0200, Marek Vasut wrote:
> But we don't care if the non-DT case gets broken anyway *. It's unsupported and 
> will be removed.
> 
We have to care about non-DT case before all those non-DT users (board
files) get removed from the tree.

-- 
Regards,
Shawn
