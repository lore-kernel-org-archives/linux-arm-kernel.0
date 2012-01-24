From: stigge@antcom.de (Roland Stigge)
Date: Tue, 24 Jan 2012 21:38:00 +0100
Subject: LPC32xx status (Re: [PATCH] Correct bad gpio naming)
In-Reply-To: <20120124192545.GB8502@pengutronix.de>
References: <4F1C4E25.6070801@antcom.de>
 <20120124155921.GH2609@pengutronix.de> <4F1EDD15.7010704@antcom.de>
 <20120124192545.GB8502@pengutronix.de>
Message-ID: <4F1F16A8.7010407@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/01/12 20:25, Wolfram Sang wrote:
>> Expect the first one of the drivers to be submitted soon, I will
>> do them one by one.
> 
> I think the first step should be adding a generic defconfig and
> make sure this builds and boots (I think I have a phy3250
> somewhere, so I could test). After that new drivers would make
> sense. IIRC clock.c was pretty broken, we needed hacks to get USB
> working with a 2.6.35. I also see that your tree modifies it.

I see that you are already at it ;-) - for the others: On the server
"git.antcom.de", I meant repository "linux-2.6.git", branch "work92105".

Unfortunately, I currently don't have a phy3250, but can check
tomorrow with colleagues.

I guess the work92105_defconfig is only useful once the drivers
currently missing in mainline are merged. Or is there an arm specific
tree I should update from?

Thanks in advance!

Roland
