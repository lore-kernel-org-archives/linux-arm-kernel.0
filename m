From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 19 Oct 2015 16:12:27 +0200
Subject: [PATCHv2 0/3] Adding FPGA Manager support for Xilinx Zynq
In-Reply-To: <20151018190840.GJ12756@jcartwri.amer.corp.natinst.com>
References: <1445035350-3569-1-git-send-email-moritz.fischer@ettus.com>
 <20151018190840.GJ12756@jcartwri.amer.corp.natinst.com>
Message-ID: <5624FA4B.8080803@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2015 09:08 PM, Josh Cartwright wrote:
> On Fri, Oct 16, 2015 at 03:42:27PM -0700, Moritz Fischer wrote:
>> Hi all,
>>
>> I've tried to address most of the feedback that was brought up,
>> the one thing I haven't looked at was the firmware format part,
>> since that was still in discussion.
>> So I'm still open to suggestions on how to handle this.
> 
> Was there disagreement?  I had thought we settled on limiting the
> handling the BIN format explicitly, the rest of the thread was about
> userspace tooling for BIT->BIN conversion.

yep. Only BIN handling and keep small BIN header with sync word.

Thanks,
Michal
