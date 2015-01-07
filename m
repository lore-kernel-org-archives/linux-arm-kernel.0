From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 07 Jan 2015 13:40:14 +0000
Subject: [PATCH v19 00/11] ARM: kprobes: OPTPROBES and other improvements.
In-Reply-To: <1420457284-76923-1-git-send-email-wangnan0@huawei.com>
References: <1420457284-76923-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1420638014.4044.52.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I think that the patches up to 09/11 inclusive have been though more
that enough review and revisions to think about getting them merged,
there doesn't seem much point in continuously resending them whilst new
features are built on top of them.

Masami Hiramatsu, are you happy for your patch to generic+X86 kprobes
code [1] to go through the ARM maintainers tree, assuming Russell is
also happy with that. Or should that go via a different route?

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/313218.html

Wang Nan, assuming everyone is happy, can you put together a branch in a
git repository for those patches, or I'm more than happy to do that if
you like. Then I can give the series a final test and we can send a pull
request to Russell King.

Thanks all

-- 
Tixy
