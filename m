From: aric@sdgsystems.com (Aric D. Blumer)
Date: Wed, 01 Dec 2010 14:54:26 -0500
Subject: bad pmd
Message-ID: <4CF6A7F2.80206@sdgsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.  I'm using the long-term stable kernel 2.6.32 on a PXA320 platform,
and I'm seeing errors like the following:

/home/aric/sdg/git/linux/mm/memory.c:144: bad pmd 8040542e.

I have seen these messages on both the 2.6.32.15 and 2.6.32.24 kernels
(haven't tried others).  Can someone tell me what the message means?  I
suspect memory is being clobbered.  One interesting thing is that
whenever that message is printed, the 8040542e is always the same.  I
have not been able to establish any correlation yet with what causes it.

Thanks for any insight you can give.

Aric.
