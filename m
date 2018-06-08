From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 7 Jun 2018 21:27:06 -0700
Subject: [v3, 00/10] Support DPAA PTP clock and timestamping
In-Reply-To: <20180607092050.46128-1-yangbo.lu@nxp.com>
References: <20180607092050.46128-1-yangbo.lu@nxp.com>
Message-ID: <20180608042706.7gfg5p6574ntc2lq@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 07, 2018 at 05:20:40PM +0800, Yangbo Lu wrote:
> This patchset is to support DPAA FMAN PTP clock and HW timestamping.
> It had been verified on both ARM platform and PPC platform.
> - The patch #1 to patch #5 are to support DPAA FMAN 1588 timer in
>   ptp_qoriq driver.
> - The patch #6 to patch #10 are to add HW timestamping support in
>   DPAA ethernet driver.

Right now, net-next is closed for new stuff.  You will have to post
the series again after the merge window closes.  You can check the
status here:

    http://vger.kernel.org/~davem/net-next.html

When you do re-post, you can add my:

Acked-by: Richard Cochran <richardcochran@gmail.com>
