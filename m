From: anderson@redhat.com (Dave Anderson)
Date: Thu, 27 Mar 2014 10:04:19 -0400 (EDT)
Subject: [PATCH 0/3] add LPAE support for kexec and kernel (Liu Hua)
In-Reply-To: <mailman.28599.1395907790.1059.kexec@lists.infradead.org>
References: <mailman.28599.1395907790.1059.kexec@lists.infradead.org>
Message-ID: <420609342.5318732.1395929059090.JavaMail.zimbra@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



----- Original Message -----

> The patch series introduce LPAE support for user space
> utility kexec(the last) and ARM linux kernel(the others).
> 
> I have tested the patch series in armA15 platform which have
> more than 4G memory.

Hello Liu,

I'm curious how you tested this?  The crash utility does not have
any specific support for LPAE on ARM, and a couple years ago I 
asked on the crash-utility mailing list whether any of the ARM
developers were working on it.  But at that time none of them were
working with LPAE.  I see that you are on the crash-utility mailing
list -- are you planning to post follow-up patches to the crash-utility?

Thanks,
  Dave

 
