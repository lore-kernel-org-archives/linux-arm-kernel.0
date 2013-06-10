From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 9 Jun 2013 23:21:08 -0400 (EDT)
Subject: [PATCH 0/2] MCPM backend for Virtual Express TC2
In-Reply-To: <1370618853.4852.28.camel@hornet>
References: <1370587152-4630-1-git-send-email-nicolas.pitre@linaro.org>
 <1370618853.4852.28.camel@hornet>
Message-ID: <alpine.LFD.2.03.1306092310570.18597@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Jun 2013, Pawel Moll wrote:

> On Fri, 2013-06-07 at 07:39 +0100, Nicolas Pitre wrote:
> > This is the MCPM backend enabling SMP secondary boot and CPU hotplug
> > on the VExpress TC2 big.LITTLE platform.  The method to allow CPU suspend
> > is also implemented.
> 
> With my Naming Purist (TM) hat on, I must point out that there is no
> such thing as TC2... The platform you're referring to is V2P-CA15_A7.
> TC2 is just an internal name for the chip (as in: Test Chip 2, which
> followed 1 and was supposed to be followed by 3 ;-). And considering the
> fact that substantial part of the power management system lives outside
> of the main chip anyway, the naming is not really precise.

Well, in people's mind, TC2 refers to the whole system now, for better 
or for worse.

> Now, I appreciate that "v2p_ca15_a7_" namespace is a bit cumbersome
> comparing to "tc2_" and no, I don't really have better ideas now...

Exactly.  If ARM wants names that stick, they'll have to be much more 
practical.  Otherwise people will simply grab the first sensible 
alternative name around.

All the ARM people I talk to always refer to v2p_ca15_a7 core tile as 
simply TC2.  So using another name at this point would only *create* 
confusion.  It is therefore probably best to keep it.

You should do like some other companies does i.e. have an official name, 
and an alias which is short and borrowed from an animal, or some 
geographical region, etc.

> Other than that:
> 
> Acked-by: Pawel Moll <pawel.moll@arm.com>

Thanks.


Nicolas
