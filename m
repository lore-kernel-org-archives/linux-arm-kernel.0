From: John.Linn@xilinx.com (John Linn)
Date: Fri, 01 Apr 2011 22:27:04 -0000
Subject: RFC, GIC based smp_cross_call cleanup suggestion
Message-ID: <10921831-0170-4106-bb3a-a52515a32c3e@VA3EHSMHS002.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm getting ready to submit a patch to add SMP to Xilinx code. I notice
that smp_cross_call for all GIC based platforms is duplicated across
each platform in smp.h.

 

I thought I'd try to jump in to help with some cleanup, although I
realize it's minimal, I have to start somewhere.

 

What about moving the smp_cross_call for GIC based designs into gic.h?

 

Or other suggestions?

 

Thanks

John



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110401/f914f022/attachment-0001.html>
