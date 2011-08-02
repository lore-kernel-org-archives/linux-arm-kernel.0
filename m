From: shaohua.li@intel.com (Shaohua Li)
Date: Tue, 02 Aug 2011 09:09:36 +0800
Subject: questions about memory hotplug
In-Reply-To: <20110801170850.GB3466@labbmf-linux.qualcomm.com>
References: <20110729221230.GA3466@labbmf-linux.qualcomm.com>
	<20110730093055.GA10672@sli10-conroe.sh.intel.com>
	<20110801170850.GB3466@labbmf-linux.qualcomm.com>
Message-ID: <1312247376.15392.454.camel@sli10-conroe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-08-02 at 01:08 +0800, Larry Bassel wrote:
> 
> In use case #1 yes, maybe not in #2 (we can arrange it to be
> at the end of memory, but then might waste memory as it may
> not be aligned on a SPARSEMEM section boundary and so would
> need to be padded).
then maybe the new migrate type I suggested can help here for the
non-aligned memory. Anyway, let me do an experiment.

Thanks,
Shaohua
