From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 17 Mar 2011 21:51:01 +0000
Subject: [PATCHv2 3/9] macb: unify at91 and avr32 platform data
In-Reply-To: <20110317093403.GA15396@pulham.picochip.com>
References: <1300184096-13937-1-git-send-email-jamie@jamieiles.com>
	<1300184096-13937-4-git-send-email-jamie@jamieiles.com>
	<87vczkmy94.fsf@macbook.be.48ers.dk>
	<AANLkTi=TiRnc0ceosH-P7fN7wKrLZE0MCJHQ30gM_Q9b@mail.gmail.com>
	<871v26m8tf.fsf@macbook.be.48ers.dk>
	<20110317085835.GC29758@n2100.arm.linux.org.uk>
	<87wrjyksnm.fsf@macbook.be.48ers.dk>
	<20110317093403.GA15396@pulham.picochip.com>
Message-ID: <20110317215101.GC2927@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2011 at 09:34:03AM +0000, Jamie Iles wrote:
> Ok, I'll rename to macb_platform_data and update at91_ether to use 
> that with a comment describing that we're sharing the platform data 
> with macb.  At least that gets rid of the preprocessor stuff in 
> board.h for at91 too.

So here's the updated patch with changes to the at91_ether driver to 
share the data with macb.

Russell, are you happy to take this series?  If so, how would you prefer 
it, in the patch system or as a git pull?

Jamie

----
