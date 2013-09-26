From: jolsa@redhat.com (Jiri Olsa)
Date: Thu, 26 Sep 2013 14:48:29 +0200
Subject: [PATCH 3/4] perf tools: Check libunwind for availability of
 dwarf parsing feature
In-Reply-To: <1380195398-4402-4-git-send-email-jean.pihet@linaro.org>
References: <1380195398-4402-1-git-send-email-jean.pihet@linaro.org>
 <1380195398-4402-4-git-send-email-jean.pihet@linaro.org>
Message-ID: <20130926124829.GA3284@krava.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 01:36:37PM +0200, Jean Pihet wrote:
> The newly added dwarf unwinding feature [1] requires:
> . a recent version (>= 1.1) of libunwind,
> . libunwind to be configured with --enable-debug-frame.
> 
> [1] http://www.spinics.net/lists/kernel/msg1598951.html
> 
> Add the corresponding API tests in the feature check list.

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka
