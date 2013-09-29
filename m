From: gang.chen@asianux.com (Chen Gang)
Date: Sun, 29 Sep 2013 11:43:13 +0800
Subject: [PATCH 0/2] ARM: include: asm: change functions' and variables' types
 in atomic.h
In-Reply-To: <20130927110618.GB9520@mudshark.cambridge.arm.com>
References: <523D7DC7.8030603@asianux.com>
 <20130924093041.GB15119@mudshark.cambridge.arm.com>
 <5242498F.8060407@asianux.com>
 <20130925160746.GC14502@mudshark.cambridge.arm.com>
 <5243953E.6010405@asianux.com>
 <20130926100422.GE2855@mudshark.cambridge.arm.com>
 <5244148F.6080405@asianux.com>
 <20130927110618.GB9520@mudshark.cambridge.arm.com>
Message-ID: <5247A1D1.6080505@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It contents 2 patches:

Patch 1: use 'long long' instead of 'u64' for within atomic.h.

Patch 2: use 'int' instead of 'unsigned long' for normal register
variables within atomic.h


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/include/asm/atomic.h |   77
+++++++++++++++++++++--------------------
 1 files changed, 39 insertions(+), 38 deletions(-)
