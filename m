From: will.deacon@arm.com (Will Deacon)
Date: Tue, 7 Aug 2012 18:59:23 +0100
Subject: Status of patch 7375/1
In-Reply-To: <50214F7D.6040001@mentor.com>
References: <50214F7D.6040001@mentor.com>
Message-ID: <20120807175923.GF16877@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wade,

On Tue, Aug 07, 2012 at 06:25:17PM +0100, Wade Farnsworth wrote:
> I'm inquiring regarding the status of patch 7375/1 in the patch tracker:
> 
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7375/1
> 
> The other two patches in the series were approved and are now in Linus's 
> tree.  However this one never received approval, nor any comments 
> indicating that it was rejected.  What is the status of this patch?  Is 
> there anything I can do to help move it forward?

There have been a bunch of fixes to the audit, syscall tracing and signal
handling code so you'll probably need to rebase your patch on top of
3.6-rc1. I think I CC'd you at the time (at least, that was my intention!).

Would you be able to do that and send it to the list again please?

Thanks,

Will
