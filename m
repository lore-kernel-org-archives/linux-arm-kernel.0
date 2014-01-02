From: olof@lixom.net (Olof Johansson)
Date: Thu, 2 Jan 2014 10:31:00 -0800
Subject: [PATCH 0/7] MSM patches for 3.14
In-Reply-To: <1387566560-23948-1-git-send-email-davidb@codeaurora.org>
References: <1387566560-23948-1-git-send-email-davidb@codeaurora.org>
Message-ID: <20140102183100.GA8684@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 11:09:13AM -0800, David Brown wrote:
> The following series contains a warning fix, a bit of cleanup, adds a
> few more boards.  There are still numerous patches floating with
> issues, but things seem to be moving in the right direction.
> 
> These have all been sent previously to the lists, and received reviews
> and necessary acks.
> 

Hi,

I've applied these across the various branches, i.e I split the series up
into fixes, soc, dt and board changes.

I chose to split the Dragonboard patch up into two patches instead of one:
One that adds SoC support, and a second that adds the board support. I
rephrased commit messages accordingly but the contents was untouched
(just split up).

I hope the clock stuff can be sorted out real quick so we get working support
for more useful IP on the SoC in time for 3.14.


-Olof
