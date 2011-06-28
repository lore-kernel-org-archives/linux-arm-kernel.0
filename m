From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Jun 2011 21:27:12 +0100
Subject: Git pull request: 64-bit atomic user helper
In-Reply-To: <alpine.LFD.2.00.1106281557440.2142@xanadu.home>
References: <alpine.LFD.2.00.1106202134510.2142@xanadu.home>
	<alpine.LFD.2.00.1106281557440.2142@xanadu.home>
Message-ID: <20110628202712.GH21898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 03:59:45PM -0400, Nicolas Pitre wrote:
> Ping.

Pulled, but you won't see it on ftp.arm for a few days yet - the ftp
partition is mounted read-only because we suspect one of the disks for
it may be unstable.

Last Friday, the machine ended up with a load average of 200+, was
impossible to log into, and on reboot, one of the four ftp partition
drives was only transferring at 3MB/s rather than its normal 40MB/s.
Since then its returned (overnight) to 38MB/s, and I've been gradually
restoring services over the last few days.  So far no signs of any
problems.
