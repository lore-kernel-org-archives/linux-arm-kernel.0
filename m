From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Thu, 30 Aug 2018 15:47:06 -0300
Subject: [PATCH v2] perf annotate: fix parsing aarch64 branch
 instructions after objdump update
In-Reply-To: <20180827125340.a2f7e291901d17cea05daba4@arm.com>
References: <20180823191047.9260992844205984b75e6721@arm.com>
 <20180827125049.GD22309@kernel.org>
 <20180827125340.a2f7e291901d17cea05daba4@arm.com>
Message-ID: <20180830184706.GH6097@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Mon, Aug 27, 2018 at 12:53:40PM -0500, Kim Phillips escreveu:
> v2: address acme's comments:
>     - consolidate into a validate_comma()
>     - call from an additional couple of places necessary
>     - don't listen to checkpatch wrt reflowing jump__parse definition
>       line to less than 80 characters, just rm the __maybe_unused
>     - re-tested no diff on x86_64 and power arch, arm64 conditional
>       branches fixed.

Thanks for taking into account my comments, applied.

- Arnaldo
