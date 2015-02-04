From: jcm@redhat.com (Jon Masters)
Date: Wed, 04 Feb 2015 15:23:27 -0500
Subject: (AArch64) NR_CPUS limit
Message-ID: <54D27FBF.8040909@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Folks,

We're currently patching our kernels with a (much) higher maximum for
NR_CPUS. There are some very large ARM systems coming soon - any
objections to increasing this to something like 1024 or 4096?

(If not I'll send Catalin the trivial patch)

Jon.
