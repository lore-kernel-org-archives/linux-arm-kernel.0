From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Mar 2015 20:24:31 +0100
Subject: [PATCH 5/6] ARM: at91: remove SoC headers
In-Reply-To: <20150304171505.GH3989@piout.net>
References: <1425480446-31711-1-git-send-email-alexandre.belloni@free-electrons.com>
 <8819576.zV70Ce3SCo@wuerfel> <20150304171505.GH3989@piout.net>
Message-ID: <4037393.1yvBxSRZeM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 March 2015 18:15:05 Alexandre Belloni wrote:
> 
> Yeah, that is still something I need to investigate. Nicolas told me it
> doesn't work without it. My guess is that it has something to do with
> secure booting.
> 

I see. It's unlikely that all four regions are needed, so I guess you
have to try out which one is actually used.

	Arnd
