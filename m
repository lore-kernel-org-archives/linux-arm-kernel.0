From: miles.chen@mediatek.com (Miles Chen)
Date: Mon, 13 Feb 2017 20:52:59 +0800
Subject: [PATCH v2] arm64: use is_vmalloc_addr
In-Reply-To: <ba5aeff9-4a02-8f5a-c5e4-e06c437875fc@suse.de>
References: <1486640734-27637-1-git-send-email-miles.chen@mediatek.com>
 <ba5aeff9-4a02-8f5a-c5e4-e06c437875fc@suse.de>
Message-ID: <1486990379.5429.1.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-02-13 at 06:20 +0100, Andreas F?rber wrote:
> Hi,
> 
> Am 09.02.2017 um 12:45 schrieb Miles Chen:
> > To is_vmalloc_addr() to check if an address is a vmalloc address
> 
> "Use ..."?

Yes, it should be "Use". I'll send another patch to fix this.

> 
> Regards,
> Andreas
> 
> > instead of checking VMALLOC_START and VMALLOC_END manually.
> > 
> > Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> 
