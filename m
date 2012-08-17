From: jarkko.nikula@bitmer.com (Jarkko Nikula)
Date: Fri, 17 Aug 2012 16:14:36 +0300
Subject: [PATCH v3 2/9] ARM: OMAP: mcbsp: Enable FIFO use for OMAP2430
In-Reply-To: <20120817130723.GZ11011@atomide.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-3-git-send-email-peter.ujfalusi@ti.com>
 <20120817130723.GZ11011@atomide.com>
Message-ID: <502E43BC.30708@bitmer.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/17/2012 04:07 PM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [120816 06:41]:
>> On OMAP2430 all McBSP ports have 128 word long buffer, enable the use of
>> the FIFO for the audio stack.
> Is this the case also for 2420? I thought some only had a FIFO at
> one port?
> 
IRCC (I don't have specs), nope. Only 2430 (as noted by Peter) and
onwards have FIFO.

But that's true that FIFO sizes differ between the ports. E.g. only
ports 2 and 3 have 1024+128 deep FIFOs in OMAP3.

-- 
Jarkko
