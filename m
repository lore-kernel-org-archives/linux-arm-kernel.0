From: adrian.hunter@intel.com (Adrian Hunter)
Date: Mon, 19 Oct 2015 13:40:14 +0300
Subject: [PATCH V2 27/30] perf build: adding X86 auxiliary specific flags
In-Reply-To: <1445192687-24112-28-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
 <1445192687-24112-28-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <5624C88E.7060200@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/10/15 21:24, Mathieu Poirier wrote:
> Adding an X86 specific flag to split AUX components that are
> generic and specific to architectures.  That way the auxiliary
> area mechanic can be compiled in for other architecture without
> including X86 specific code.

The idea is that you *should* be able to take a perf.data file from one
architecture and process it on another architecture.
