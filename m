From: broonie@kernel.org (Mark Brown)
Date: Tue, 19 Jan 2016 17:50:38 +0000
Subject: [RFC PATCH v2 0/4] CPUs capacity information for heterogeneous
 systems
In-Reply-To: <20160119150551.GI6344@twins.programming.kicks-ass.net>
References: <1452262172-31861-1-git-send-email-juri.lelli@arm.com>
 <20160119150551.GI6344@twins.programming.kicks-ass.net>
Message-ID: <20160119175038.GS6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 04:05:51PM +0100, Peter Zijlstra wrote:
> On Fri, Jan 08, 2016 at 02:09:28PM +0000, Juri Lelli wrote:

> >     cons: - not easy to come up with a clean solution, as it seems interaction
> >             with several subsystems (e.g., cpufreq) is required
> >           - not easy to agree upon a single benchmark (that has to be both
> >             representative and simple enough to run at boot)
> >           - numbers might (and do) vary from boot to boot

> This last point is a total pain for benchmarking, it means nothing is
> every reproducible.

> Therefore, I would always augment the above (2) with the below (3), such
> that you can overwrite the results with a known stable set of numbers:

The suggestion when the previous version was being discussed was that
there are supposed to be some other knobs one uses for tuning and one
was never supposed to use these numbers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160119/2f579d28/attachment.sig>
