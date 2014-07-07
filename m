From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Jul 2014 04:53:00 -0700
Subject: [PATCH] arch: arm: mach-omap2: usb-tusb6010.c:  Cleaning up
 variable is set more than once
In-Reply-To: <1403699310-22960-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1403699310-22960-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <20140707115300.GV28884@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se> [140625 05:29]:
> A struct member variable is set to the same value more than once
> 
> This was found using a static code analysis program called cppcheck.

Applying into omap-for-v3.17/fixes-not-urgent thanks.

Tony
