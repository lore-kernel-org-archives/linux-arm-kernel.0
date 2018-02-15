From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Thu, 15 Feb 2018 11:56:17 -0300
Subject: [PATCH] perf-tools: cs-etm: Properly deal with cpu maps
In-Reply-To: <1518478737-24649-1-git-send-email-mathieu.poirier@linaro.org>
References: <1518478737-24649-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20180215145617.GD30974@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Mon, Feb 12, 2018 at 04:38:57PM -0700, Mathieu Poirier escreveu:
> This patch allows the CoreSight AUX info section to fit topologies where
> only a subset of all available CPUs are present, avoiding at the same time
> accessing the ETM configuration areas of CPUs that have been offlined.

Thanks, applied.

- Arnaldo
