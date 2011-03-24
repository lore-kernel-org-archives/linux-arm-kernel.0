From: horms@verge.net.au (Simon Horman)
Date: Thu, 24 Mar 2011 15:54:06 +0900
Subject: [PATCH 0/2] mmc: zboot helpers
Message-ID: <1300949648-15078-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

please consider merging the following two patches.
They are both pre-requisites for
"mmc, ARM: Add zboot from eSD support for SuperH Mobile ARM"
which I plan to submit to Russell King.

These patches were originally submitted in a for patch series
however they do not depend on any of the other patches in the series
so I am posting them independently.

These patches apply against Linus's current tree
and I am not aware of any particular prerequisites for them
other than that the 2nd patch depends on the 1st one.
