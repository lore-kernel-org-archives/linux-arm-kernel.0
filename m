From: vapier@gentoo.org (Mike Frysinger)
Date: Thu, 3 Nov 2011 22:05:52 -0400
Subject: [PATCH 0/3] Change ARCH_NR_GPIO into a Kconfig variable
In-Reply-To: <20111103231707.GU12913@n2100.arm.linux.org.uk>
References: <1320339647-30255-1-git-send-email-pdeschrijver@nvidia.com>
	<201111031907.46434.vapier@gentoo.org>
	<20111103231707.GU12913@n2100.arm.linux.org.uk>
Message-ID: <201111032205.56557.vapier@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 November 2011 19:17:07 Russell King - ARM Linux wrote:
> (b) that's effectively what it is - if you understand what's going on with
> the 'default' statements.
> 
> For any option, there can be multiple 'default' statements:

thanks, i wasn't aware of the cascading nature of the default keyword
-mike
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111103/757fccb9/attachment.sig>
