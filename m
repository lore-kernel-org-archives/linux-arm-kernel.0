From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Fri, 19 Jan 2018 12:01:55 -0300
Subject: [PATCH v3 00/10] perf tools: Add support for CoreSight trace
 decoding
In-Reply-To: <1516211539-5166-1-git-send-email-mathieu.poirier@linaro.org>
References: <1516211539-5166-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20180119150155.GD23453@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Wed, Jan 17, 2018 at 10:52:09AM -0700, Mathieu Poirier escreveu:
> Hi Arnaldo,
> 
> This patchset adds support for per-thread CoreSight trace decoding from the
> "perf report" interface.  It is largely modelled on what has been done for
> intelPT traces and currently targets the ETMv4 architecture.  Support for
> cpu-wide scenarios and ETMv3/PTMv1.1 will follow shortly.

Adrian, have you had the time to give this a quick look, in the spirit
of checking if the Intel PT abstractions they followed are ok in their
implementation?

- Arnaldo
