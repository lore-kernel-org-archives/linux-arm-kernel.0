From: gang.chen@asianux.com (Chen Gang)
Date: Tue, 08 Oct 2013 18:56:51 +0800
Subject: [PATCH v2 0/2] ARM: include: asm: change functions' and variables'
 types in atomic.h
In-Reply-To: <20131008103455.GF17148@mudshark.cambridge.arm.com>
References: <20131002104158.GD28311@mudshark.cambridge.arm.com>
 <524C3981.20307@asianux.com> <524D416B.5090709@asianux.com>
 <20131003163200.GE7408@mudshark.cambridge.arm.com>
 <524E8FBC.2080200@asianux.com>
 <20131004153742.GR24303@mudshark.cambridge.arm.com>
 <20131004154208.GS24303@mudshark.cambridge.arm.com>
 <524F5566.4010204@asianux.com> <524F594B.1070106@asianux.com>
 <525385A4.5050200@asianux.com>
 <20131008103455.GF17148@mudshark.cambridge.arm.com>
Message-ID: <5253E4F3.4090205@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It contents 2 patches:

Patch 1: use 'long long' instead of 'u64' for within atomic.h.

Patch 2: use 'int' instead of 'unsigned long' for 'oldval' in
atomic_cmpxchg().


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/include/asm/atomic.h |   52 +++++++++++++++++++++-------------------
 1 files changed, 27 insertions(+), 25 deletions(-)
