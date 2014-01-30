From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 30 Jan 2014 10:24:38 +0100
Subject: [PATCH v2 5/6] X86: remove redundant cpuidle_idle_call()
In-Reply-To: <alpine.LFD.2.11.1401291434120.1652@knanqh.ubzr>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
 <1391017513-12995-6-git-send-email-nicolas.pitre@linaro.org>
 <CAOesGMjvOkuxCopog91SAV1-gB9GaEYXpuXwhV1EJQor_pKjBA@mail.gmail.com>
 <alpine.LFD.2.11.1401291434120.1652@knanqh.ubzr>
Message-ID: <20140130092438.GK11314@laptop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 03:14:40PM -0500, Nicolas Pitre wrote:
> Looking into some cpuidle drivers for x86 I found at least one that 
> doesn't respect this convention.  Damn.

Which one? We should probably fix it :-)
