From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 28 Jun 2018 08:48:38 +0800
Subject: [PATCH v3 1/3] cpufreq: imx6q: check speed grades for i.MX6ULL
In-Reply-To: <2d63a25f-7265-7aa7-a7dc-fd2379240804@armadeus.com>
References: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
 <20180611053826.GC16091@dragon>
 <2d63a25f-7265-7aa7-a7dc-fd2379240804@armadeus.com>
Message-ID: <20180628004837.GB22683@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 10:01:44AM +0200, S?bastien Szymanski wrote:
> Hi,
> 
> On 06/11/2018 07:38 AM, Shawn Guo wrote:
> > On Tue, May 22, 2018 at 08:28:51AM +0200, S?bastien Szymanski wrote:
> >> Check the max speed supported from the fuses for i.MX6ULL and update the
> >> operating points table accordingly.
> >>
> >> Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
> > 
> > Acked-by: Shawn Guo <shawnguo@kernel.org>
> > 
> 
> Thanks, but what about the two others patches ? Now that patch 1 is in
> 4.18-rc1, should I resend the two others patches ? Should I merge them
> together ?

Yes, please.  That's what Viresh and Stefan were asking in the review.

Shawn
