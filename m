From: broonie@kernel.org (Mark Brown)
Date: Wed, 15 Jun 2016 15:04:47 +0100
Subject: [PATCH v5 1/8] Documentation: arm: define DT cpu
 capacity-dmips-mhz bindings
In-Reply-To: <1465985877-18271-2-git-send-email-juri.lelli@arm.com>
References: <1465985877-18271-1-git-send-email-juri.lelli@arm.com>
 <1465985877-18271-2-git-send-email-juri.lelli@arm.com>
Message-ID: <20160615140447.GB2282@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 11:17:50AM +0100, Juri Lelli wrote:

> +CPU capacities are obtained by running a suitable benchmark. This binding makes
> +no aspersions on the validity or suitability of any particular benchmark, the
> +final capacity should, however, be:

Makes no guarantees.  An aspersion is an insult!

> +CPU capacities are obtained by running the Dhrystone benchmark on each CPU at
> +max frequency. The obtained DMIPS score is then divided by the frequency (in
> +MHz) at which the benchmark has been run, so that DMIPS/MHz are obtained.
> +Such values are then normalized w.r.t. the highest score obtained in the
> +system.

Perhaps worth mentioning that caches and so on should be enabled (based
on previous experience with people doing bringup)?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160615/384c7778/attachment.sig>
