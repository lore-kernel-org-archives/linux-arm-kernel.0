From: gking@nvidia.com (gking at nvidia.com)
Date: Wed, 28 Jul 2010 17:57:45 -0700
Subject: [RFC 0/2] DMA bounce alignment and highmem support
Message-ID: <1280365067-21102-1-git-send-email-gking@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series extends the dmabounce code to allow DMA masks
with cleared low bits to be specified by platforms which need
DMA bouncing for alignment purposes (in addition to the current
bounce-for-aperture support), and to support bouncing to/from highmem
pages.


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
