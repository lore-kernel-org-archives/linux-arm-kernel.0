From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 09 Nov 2011 20:17:05 +0100
Subject: CONFIG_CPU_FREQ_DEBUG
Message-ID: <1320866225.27598.11.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

0) Commit 2d06d8c49afdcc9bb35a85039fa50f0fe35bd40e ("[CPUFREQ] use
dynamic debug instead of custom infrastructure") dropped config
CPU_FREQ_DEBUG. But currently there are still two references to
CONFIG_CPU_FREQ_DEBUG (both in arch/arm).

1) I've stared a bit at the (trivial) code still relying on
CONFIG_CPU_FREQ_DEBUG but wasn't sure how it could be rewritten. Perhaps
one of you does know how to do that.


Paul Bolle
