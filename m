From: joshc@ni.com (Josh Cartwright)
Date: Sun, 18 Oct 2015 14:08:40 -0500
Subject: [PATCHv2 0/3] Adding FPGA Manager support for Xilinx Zynq
In-Reply-To: <1445035350-3569-1-git-send-email-moritz.fischer@ettus.com>
References: <1445035350-3569-1-git-send-email-moritz.fischer@ettus.com>
Message-ID: <20151018190840.GJ12756@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 03:42:27PM -0700, Moritz Fischer wrote:
> Hi all,
> 
> I've tried to address most of the feedback that was brought up,
> the one thing I haven't looked at was the firmware format part,
> since that was still in discussion.
> So I'm still open to suggestions on how to handle this.

Was there disagreement?  I had thought we settled on limiting the
handling the BIN format explicitly, the rest of the thread was about
userspace tooling for BIT->BIN conversion.

  Josh
