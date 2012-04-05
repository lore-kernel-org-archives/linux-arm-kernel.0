From: p2@debian.org (Peter 'p2' De Schrijver)
Date: Thu, 5 Apr 2012 15:03:53 +0300
Subject: [RFC PATCH] cpuidle: allow per cpu latencies
In-Reply-To: <1333625136-22630-1-git-send-email-pdeschrijver@nvidia.com>
References: <1333625136-22630-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20120405120352.GL6489@apfelkorn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-04-05 14:25:23 (+0300), Peter De Schrijver <pdeschrijver@nvidia.com> wrote:
> On some systems (eg Tegra30) latencies for a given C state are not equal for
> all CPUs. Therefore we introduce a new per CPU structure which contains
> those parameters.

Sorry for sending this several times.

Cheers,

Peter.
