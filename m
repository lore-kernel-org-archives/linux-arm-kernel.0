From: John.Linn@xilinx.com (John Linn)
Date: Wed, 6 Apr 2011 07:48:34 -0600
Subject: For SMP,
	Is platform specific secondary startup function really needed?
Message-ID: <7b2e9aed-1162-43f3-8c33-59b43b0a1964@VA3EHSMHS036.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm doing some cleanup of SMP patches based on Russell and Catalin's
input which was real helpful. It seems to me that there is not always a
need for a platform specific secondary startup.

I have tested with just letting CPU1 go straight to secondary_startup()
in head.S and it works fine.

I'm probably missing something obvious, if so can you share it?

Thanks,
John

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
