From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 9 Aug 2011 16:59:40 +0200
Subject: [PATCHv3 0/9] macb: add support for Cadence GEM
In-Reply-To: <1312881411-2376-1-git-send-email-jamie@jamieiles.com>
References: <1312881411-2376-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20110809145940.GP22213@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:16 Tue 09 Aug     , Jamie Iles wrote:
> This is largely a repost of the series I posted back in March.  The only changes
> since then are rebasing onto 3.1-rc1 and changing the gem conditionals from a
> boolean in the macb structure to an inline helper as requested by
> Jean-Christophe.
> 
> This has been run-tested on picoxcell and compile tested for all AT91 platforms
> but I couldn't get a working cross compiler for avr32.
> 
> All patches are available in a git branch at
> 
> 	git://github.com/jamieiles/linux-2.6-ji.git macb-gem
> 
looks good except few comments

I'll test it later this week

Best Regards,
J.
