From: tony@atomide.com (Tony Lindgren)
Date: Wed, 2 Apr 2014 09:21:03 -0700
Subject: OMAP baseline test results for v3.14
In-Reply-To: <alpine.DEB.2.02.1404021600320.15928@utopia.booyaka.com>
References: <alpine.DEB.2.02.1404021600320.15928@utopia.booyaka.com>
Message-ID: <20140402162102.GB12234@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [140402 09:07]:
> 
> Here are some basic OMAP test results for Linux v3.14.
> Logs and other details at:
> 
>     http://www.pwsan.com/omap/testlogs/test_v3.14/20140402004448/
> 
> Boot to userspace:
>     FAIL ( 1/12): 2430sdp

Is this a new regression with MMC? Looks like your boot log for this
ends with "Waiting for root device /dev/mmcblk0p1...".

Regards,

Tony
