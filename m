From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 13 Jun 2014 11:02:39 +0300
Subject: [PATCH RESEND] clk: flatten clk tree in debugfs
In-Reply-To: <1401462237-14954-1-git-send-email-pdeschrijver@nvidia.com>
References: <1401462237-14954-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20140613080239.GO5961@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 05:03:57PM +0200, Peter De Schrijver wrote:
> This patch flattens the clk tree in CCF debugfs. Instead of representing the
> clocks and their hierarchy as a directory structure under
> /sys/kernel/debug/clk, each clock gets a single directory directly under
> /sys/kernel/debug/clk. The orphans directory is replaced by a file called
> clk_orphan_summary.

Mike,

Any problems with this? What needs to be done to make this patch go forward?

Thanks!

Peter.
