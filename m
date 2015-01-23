From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Fri, 23 Jan 2015 17:59:59 -0300
Subject: perf not capturing stack traces
In-Reply-To: <20150123195128.GE26557@saruman.tx.rr.com>
References: <20150123195128.GE26557@saruman.tx.rr.com>
Message-ID: <20150123205959.GD3073@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Fri, Jan 23, 2015 at 01:51:28PM -0600, Felipe Balbi escreveu:
> I'm using v3.19-rc5 on an ARM Cortex A9 board. Unfortunately, perf is
> not able to capture any stack traces even though I CONFIG_STACKTRACE,
> CONFIG_FRAME_POINTER and CONFIG_ARM_UNWIND all enabled.
> 
> I wonder if anybody else is facing similar issues.

Did it work with a previous kernel?

- Arnaldo
