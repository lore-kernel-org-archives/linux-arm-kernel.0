From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 12 Feb 2018 14:34:29 +0100
Subject: [PATCH] acpi, spcr: Make SPCR available to x86
In-Reply-To: <20180118150951.28964-1-prarit@redhat.com>
References: <20180118150951.28964-1-prarit@redhat.com>
Message-ID: <20180212133429.GC25314@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 18, 2018 at 10:09:51AM -0500, Prarit Bhargava wrote:
>  config ACPI_SPCR_TABLE
> +	bool "ACPI Serial Port Console Redirection Support"
> +	default y if X86
> +	help
> +	  Enable support for Serial Port Console Redirection (SPCR) Table.
> +	  This table provides information about the configuration of the
> +	  earlycon console.

I just got asked this by oldconfig, which left me rather puzzled, WTF
does this do?
