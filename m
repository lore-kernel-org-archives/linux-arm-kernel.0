From: horms@verge.net.au (Simon Horman)
Date: Thu, 4 Apr 2013 11:00:20 +0900
Subject: APE6EVM and Runtime PM
Message-ID: <20130404020019.GA7163@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

in the course of looking look at consolidating our defconfigs I
noticed that SMSC ethernet and rcar_thermal seem seem to not work when
runtime PM is enabled.

I'm wondering if you have any ideas of what might be the cause of this
or if you could give me some guidance on investigating this problem.

I assume that it relates to a clock or clocks not being enabled.
