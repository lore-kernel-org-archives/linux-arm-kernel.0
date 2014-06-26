From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 26 Jun 2014 19:39:06 +0300
Subject: [PATCH RESEND] clk: flatten clk tree in debugfs
In-Reply-To: <20140613080239.GO5961@tbergstrom-lnx.Nvidia.com>
References: <1401462237-14954-1-git-send-email-pdeschrijver@nvidia.com>
 <20140613080239.GO5961@tbergstrom-lnx.Nvidia.com>
Message-ID: <20140626163906.GI3679@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 13, 2014 at 10:02:39AM +0200, Peter De Schrijver wrote:
> On Fri, May 30, 2014 at 05:03:57PM +0200, Peter De Schrijver wrote:
> > This patch flattens the clk tree in CCF debugfs. Instead of representing the
> > clocks and their hierarchy as a directory structure under
> > /sys/kernel/debug/clk, each clock gets a single directory directly under
> > /sys/kernel/debug/clk. The orphans directory is replaced by a file called
> > clk_orphan_summary.
> 
> Mike,
> 
> Any problems with this? What needs to be done to make this patch go forward?
> 

Do you think this could be merged for the 3.17?

Thanks,

Peter.
