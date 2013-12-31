From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 31 Dec 2013 15:58:53 -0800
Subject: [PATCH] Slightly outdated CONFIG_SMP documentation fix
In-Reply-To: <20131231225921.GA1624@sylph>
References: <20131231225921.GA1624@sylph>
Message-ID: <52C35A3D.8090109@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/31/2013 02:59 PM, Robert Graffham wrote:
> I've removed a reference to "most personal computers" being singleprocessor
> machines in multiple arches' config help, and also brought the arch/arm spacing
> for "singleprocessor" (vs. "single processor" used there originally) in line
> with other arches that had that text.
> 
> The diff is included below, and cleanly applies and builds on my system. I have
> not tested on other systems yet since a documentation fix shouldn't fail to
> build inconsistently, but if that's no excuse, I'll be happy to test further
> when I can.
> 

Acked-by: H. Peter Anvin <hpa@linux.intel.com>
