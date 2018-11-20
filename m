From: mpe@ellerman.id.au (Michael Ellerman)
Date: Tue, 20 Nov 2018 22:31:36 +1100
Subject: [PATCH 10/10] perf/doc: update design.txt for
 exclude_{host|guest} flags
In-Reply-To: <1542363853-13849-11-git-send-email-andrew.murray@arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
 <1542363853-13849-11-git-send-email-andrew.murray@arm.com>
Message-ID: <87pnv00yuf.fsf@concordia.ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew Murray <andrew.murray@arm.com> writes:

> Update design.txt to reflect the presence of the exclude_host
> and exclude_guest perf flags.
>
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  tools/perf/design.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/design.txt b/tools/perf/design.txt
> index a28dca2..7de7d83 100644
> --- a/tools/perf/design.txt
> +++ b/tools/perf/design.txt
> @@ -222,6 +222,10 @@ The 'exclude_user', 'exclude_kernel' and 'exclude_hv' bits provide a
>  way to request that counting of events be restricted to times when the
>  CPU is in user, kernel and/or hypervisor mode.
>  
> +Furthermore the 'exclude_host' and 'exclude_guest' bits provide a way
> +to request counting of events restricted to guest and host contexts when
> +using virtualisation.

How does exclude_host differ from exclude_hv ?

cheers
