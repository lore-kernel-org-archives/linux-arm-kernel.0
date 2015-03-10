From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 10 Mar 2015 19:42:02 +0100
Subject: [PATCH] cpuidle: mvebu: update cpuidle thresholds for Armada XP
 SOCs
In-Reply-To: <54FF3967.1090602@linaro.org>
References: <alpine.LNX.2.02.1502131534360.8729@sbrk.sbrk.org>
 <20150310190507.64b3c153@free-electrons.com>
 <54FF3967.1090602@linaro.org>
Message-ID: <20150310184202.GB10838@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 07:35:19PM +0100, Daniel Lezcano wrote:
> On 03/10/2015 07:05 PM, Thomas Petazzoni wrote:
> >Hello Daniel,
> >
> >I know you suggested a more rigorous method of determining the exit
> >latency and target residency times, but would it be nonetheless
> >possible to apply this patch, which clearly improves performance a lot,
> >and actually makes the code match the values used in the vendor kernel?
> >
> >I also think this patch should be marked for stable, it fixes values
> >introduced in commit b858fbc1919720f7f54360098ece03b383e961fa, and
> >should therefore be backported all the way to v3.16.
> 
> I don't have a problem to apply this patch. But I would like to have
> confirmation from one of the Armada maintainers the tradeoff is
> accepted (less energy saving for more performance).

Hi Daniel

I believe Gregory has already acked this patch. Or do you want a 
explicit Acked-and-tradeoff-accepted-by: 

	 Andrew
