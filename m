From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Fri, 16 Jun 2017 13:13:05 -0300
Subject: [PATCH 2/2] perf coresight: Remove superfluous check before use
In-Reply-To: <20170616143125.GA30102@xps15>
References: <20170615125521.80cc128dc856bc1f2e61b730@arm.com>
 <20170616143125.GA30102@xps15>
Message-ID: <20170616161305.GF3645@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Fri, Jun 16, 2017 at 08:31:25AM -0600, Mathieu Poirier escreveu:
> On Thu, Jun 15, 2017 at 12:55:21PM -0500, Kim Phillips wrote:
> > cs_etm_evsel is guaranteed to be set at this point in the function.
> > 
> 
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks, applied.

- Arnaldo
