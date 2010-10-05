From: lethal@linux-sh.org (Paul Mundt)
Date: Tue, 5 Oct 2010 17:08:34 +0900
Subject: [PATCH 6/7] sh: oprofile: Use perf-events oprofile backend
In-Reply-To: <db62cbe463d5bce89196d6456ad386129ce0022a.1286222593.git.matt@console-pimps.org>
References: <cover.1286222593.git.matt@console-pimps.org>
	<db62cbe463d5bce89196d6456ad386129ce0022a.1286222593.git.matt@console-pimps.org>
Message-ID: <20101005080833.GA7984@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 04, 2010 at 09:44:24PM +0100, Matt Fleming wrote:
> Now that we've got a generic perf-events based oprofile backend we might
> as well make use of it seeing as SH doesn't do anything special with its
> oprofile backend. Also introduce a new CONFIG_HW_PERF_EVENTS symbol so
> that we can fallback to using the timer interrupt for oprofile if the
> CPU doesn't support perf events.
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>

Acked-by: Paul Mundt <lethal@linux-sh.org>
