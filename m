From: marc@cpdesign.com.au (Marc Reilly)
Date: Sat, 24 Mar 2012 09:43:06 +1100
Subject: [PATCH] regulator: i.MX35-PDK Add regulator support
In-Reply-To: <1332526267-3236-1-git-send-email-alexg@meprolight.com>
References: <1332526267-3236-1-git-send-email-alexg@meprolight.com>
Message-ID: <201203240943.06346.marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex, 

> Thanks for the patches.
> 
> v4 3/4 not directly applicable to Linux version 3.3,
> I installed it manually, you could check it out?

That patch series was based on mfd-2.6/for-next because it should be accepted 
in the kernel through the mfd tree. (look in the Maintainers file for the mfd 
git repo uri).

You could rebase it for 3.3 kernel for your own use. My guess is that the 
confilcts are in the Kconfig or Makefile so it won't be too much trouble.

Cheers,
Marc
