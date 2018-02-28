From: p.pisati@gmail.com (Paolo Pisati)
Date: Wed, 28 Feb 2018 17:25:54 +0100
Subject: Internal error: Oops - BUG() / kvm boot race - arm64 kpti
 patchset related
In-Reply-To: <20180228161833.GB22612@arm.com>
References: <20180228154523.GA29931@akinoame> <20180228160735.GA22612@arm.com>
 <20180228161256.GA31013@akinoame> <20180228161833.GB22612@arm.com>
Message-ID: <20180228162554.GD31013@akinoame>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 04:18:33PM +0000, Will Deacon wrote:
> > 
> > Oops log here:
> > https://launchpadlibrarian.net/358687166/submission_2018-02-26T14.58.17.996524.html#9-1-log
> 
> The patch that Ard linked to should resolve that particular crash.
> I see this is a 4.13-based kernel. Is the source tree available anywhere?

https://git.launchpad.net/~p-pisati/ubuntu/+source/linux/log/?h=artful-master-next-arm64-kpti-414-backport

I'll try that patch, thanks.
-- 
bye,
p.
