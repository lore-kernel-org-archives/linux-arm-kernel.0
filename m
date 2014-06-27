From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 27 Jun 2014 10:29:09 +0300
Subject: [PATCH RESEND] clk: flatten clk tree in debugfs
In-Reply-To: <20140626213645.32686.26036@quantum>
References: <1401462237-14954-1-git-send-email-pdeschrijver@nvidia.com>
 <20140613080239.GO5961@tbergstrom-lnx.Nvidia.com>
 <20140626163906.GI3679@tbergstrom-lnx.Nvidia.com>
 <20140626213645.32686.26036@quantum>
Message-ID: <20140627072909.GJ3679@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 11:36:45PM +0200, Mike Turquette wrote:
> Quoting Peter De Schrijver (2014-06-26 09:39:06)
> > On Fri, Jun 13, 2014 at 10:02:39AM +0200, Peter De Schrijver wrote:
> > > On Fri, May 30, 2014 at 05:03:57PM +0200, Peter De Schrijver wrote:
> > > > This patch flattens the clk tree in CCF debugfs. Instead of representing the
> > > > clocks and their hierarchy as a directory structure under
> > > > /sys/kernel/debug/clk, each clock gets a single directory directly under
> > > > /sys/kernel/debug/clk. The orphans directory is replaced by a file called
> > > > clk_orphan_summary.
> > > 
> > > Mike,
> > > 
> > > Any problems with this? What needs to be done to make this patch go forward?
> 
> Applied to clk-next.
> 

Thanks!

Peter.
