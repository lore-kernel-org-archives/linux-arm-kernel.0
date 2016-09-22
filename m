From: davem@davemloft.net (David Miller)
Date: Thu, 22 Sep 2016 08:25:40 -0400 (EDT)
Subject: [PATCH 0/2] BQL support and fix for a regression issue
In-Reply-To: <1474535121-13958-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1474535121-13958-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <20160922.082540.992436214283504080.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: sunil.kovvuri@gmail.com
Date: Thu, 22 Sep 2016 14:35:19 +0530

> From: Sunil Goutham <sgoutham@cavium.com>
> 
> These patches add byte queue limit support and also fixes a regression
> issue introduced by commit
> 'net: thunderx: Use netdev's name for naming VF's interrupts'

The correct way to refer to commits when you fix a bug is
to use the "Fixes: " tag right before the signoffs and ACKs.

The correct form is:

Fixes: $SHA1_ID ("Commit header line.")

You'll see this in many other netdev commits.
