From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 5 Mar 2010 09:04:09 +0200
Subject: [PATCH] s3c244x: Fix compilation issue due to moved
	cpufreq-related files
In-Reply-To: <20100304232006.GA31126@trinity.fluff.org>
References: <1267627095-24200-1-git-send-email-anarsoul@gmail.com>
	<20100304232006.GA31126@trinity.fluff.org>
Message-ID: <201003050904.27297.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 5 ????? 2010 01:20:06 ????? Ben Dooks ???????:

> I've fixed this by moving the files instead of hte makefile. Commit will
> be in next-samsung soon. Thanks for pointing this out.

Sorry, but it seems you forgot about s3c2440-cpufreq.c in commit 8997de30ad 
(look at my patch again :)). Please move it from plat-s3c244x to arch-s3c2440 
too.

Regards,
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100305/79aa97f0/attachment.sig>
