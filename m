From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Thu, 22 Sep 2016 06:12:16 -0700
Subject: [PATCH 0/2] BQL support and fix for a regression issue
In-Reply-To: <20160922.082540.992436214283504080.davem@davemloft.net>
References: <1474535121-13958-1-git-send-email-sunil.kovvuri@gmail.com>
 <20160922.082540.992436214283504080.davem@davemloft.net>
Message-ID: <1474549936.23058.98.camel@edumazet-glaptop3.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-09-22 at 08:25 -0400, David Miller wrote:
> From: sunil.kovvuri at gmail.com
> Date: Thu, 22 Sep 2016 14:35:19 +0530
> 
> > From: Sunil Goutham <sgoutham@cavium.com>
> > 
> > These patches add byte queue limit support and also fixes a regression
> > issue introduced by commit
> > 'net: thunderx: Use netdev's name for naming VF's interrupts'
> 
> The correct way to refer to commits when you fix a bug is
> to use the "Fixes: " tag right before the signoffs and ACKs.
> 
> The correct form is:
> 
> Fixes: $SHA1_ID ("Commit header line.")
> 
> You'll see this in many other netdev commits.

Thanks a lot David for this enforcement, it really helps bug tracking
and backports

Note that the $SHA1_ID should be truncated to 12 first chars.

Refer to Documentation/SubmittingPatches around line 191 for more
details.
