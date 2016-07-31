From: jolsa@redhat.com (Jiri Olsa)
Date: Sun, 31 Jul 2016 14:03:10 +0200
Subject: [PATCH V3 4/6] perf tools: pushing driver configuration down to
 the kernel
In-Reply-To: <1469742143-22245-5-git-send-email-mathieu.poirier@linaro.org>
References: <1469742143-22245-1-git-send-email-mathieu.poirier@linaro.org>
 <1469742143-22245-5-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20160731120310.GB12673@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 28, 2016 at 03:42:21PM -0600, Mathieu Poirier wrote:
> Now that PMU specific driver configuration are queued in
> evsel::config_terms, all we need to do is re-use the current
> ioctl() mechanism to push down the information to the kernel
> driver.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  tools/perf/builtin-record.c |  9 +++++++++
>  tools/perf/builtin-stat.c   |  8 ++++++++

how about perf top?

jirka
