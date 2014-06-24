From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 24 Jun 2014 07:46:47 -0400
Subject: [PATCH] ARM: mvebu: Fix the improper use of the compatible
 string armada38x using a wildcard
In-Reply-To: <53A92EEF.6070803@free-electrons.com>
References: <1403533011-21339-1-git-send-email-gregory.clement@free-electrons.com>
 <20140623215309.GD10202@titan.lakedaemon.net>
 <53A92EEF.6070803@free-electrons.com>
Message-ID: <20140624114647.GI10202@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 09:55:27AM +0200, Gregory CLEMENT wrote:
> Hi Jason,
> 
> >> This fix should be merged in 3.16 and maybe sent as a fix for 3.15
> >> too.
> 
> [...]
> 
> > Applied to mvebu/dt with Andrew's Ack.
> 
> I think it should go mvebu/fixes as this patch modifies the binding,
> sooner is better.

oops.  Yeah, I f'd that up.  Sorry.  Fixed now.  I've Cc'd stable for
v3.15+

thx,

Jason.
