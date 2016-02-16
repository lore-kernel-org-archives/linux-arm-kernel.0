From: borntraeger@de.ibm.com (Christian Borntraeger)
Date: Tue, 16 Feb 2016 19:46:03 +0100
Subject: [BUG] random kernel crashes after THP rework on s390 (maybe also
 on PowerPC and ARM)
In-Reply-To: <20160215213526.GA9766@node.shutemov.name>
References: <20160211192223.4b517057@thinkpad>
 <20160211190942.GA10244@node.shutemov.name>
 <20160211205702.24f0d17a@thinkpad>
 <20160212154116.GA15142@node.shutemov.name> <56BE00E7.1010303@de.ibm.com>
 <20160212181640.4eabb85f@thinkpad>
 <20160212231510.GB15142@node.shutemov.name>
 <alpine.LFD.2.20.1602131238260.1910@schleppi>
 <20160215113159.GA28832@node.shutemov.name>
 <20160215193702.4a15ed5e@thinkpad> <20160215213526.GA9766@node.shutemov.name>
Message-ID: <56C36E6B.70009@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/15/2016 10:35 PM, Kirill A. Shutemov wrote:
> 
> Is there any chance that I'll be able to trigger the bug using QEMU?
> Does anybody have an QEMU image I can use?

qemu/TCG on s390 does neither provide SMP nor large pages (only QEMU/KVM does)
so this will probably not help you here. 

Christian
