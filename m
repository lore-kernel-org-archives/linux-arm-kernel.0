From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Sep 2013 18:15:03 +0100
Subject: [PATCH] perf tools: Check libunwind for availability of dwarf
 parsing feature
In-Reply-To: <1379092121-5981-1-git-send-email-jean.pihet@linaro.org>
References: <1379092121-5981-1-git-send-email-jean.pihet@linaro.org>
Message-ID: <20130913171503.GC14224@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

On Fri, Sep 13, 2013 at 06:08:41PM +0100, Jean Pihet wrote:
> The newly added dwarf unwinding feature [1] requires:
> . a recent version (>= 1.1) of libunwind,
> . libunwind to be configured with --enable-debug-frame.
> 
> [1] http://www.spinics.net/lists/kernel/msg1598951.html
> 
> Add the corresponding API test in the feature check list.

Any reason not to merge this in with the third patch in original series? I
don't think it's been picked up by anybody yet, so it would make sense to
repost with this fixup after the merge window.

Will
