From: sebott@linux.vnet.ibm.com (Sebastian Ott)
Date: Fri, 19 Feb 2016 15:15:50 +0100 (CET)
Subject: [BUG] random kernel crashes after THP rework on s390 (maybe also
 on PowerPC and ARM)
In-Reply-To: <20160218170658.GC28184@node.shutemov.name>
References: <20160211190942.GA10244@node.shutemov.name>
 <20160211205702.24f0d17a@thinkpad>
 <20160212154116.GA15142@node.shutemov.name> <56BE00E7.1010303@de.ibm.com>
 <20160212181640.4eabb85f@thinkpad>
 <20160212231510.GB15142@node.shutemov.name>
 <alpine.LFD.2.20.1602131238260.1910@schleppi>
 <20160217201340.2dafad8d@thinkpad>
 <20160217235808.GA21696@node.shutemov.name>
 <20160218160037.627cc7ec@thinkpad>
 <20160218170658.GC28184@node.shutemov.name>
Message-ID: <alpine.LFD.2.20.1602191509270.1742@schleppi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, 18 Feb 2016, Kirill A. Shutemov wrote:
> I worth minimizing kernel config on which you can see the bug. Things like
> CONFIG_DEBUG_PAGEALLOC used to interfere with THP before.

I disabled all debugging options (using
arch/s390/configs/performance_defconfig) - we still chrashed.

Sebastian
