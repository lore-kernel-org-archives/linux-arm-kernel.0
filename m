From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 23 Mar 2016 15:46:11 +0100
Subject: [PATCH V1] perf: qcom: Add L3 cache PMU driver
In-Reply-To: <f33a9ea23bf426c138a9323e53703259@codeaurora.org>
References: <1458333422-8963-1-git-send-email-agustinv@codeaurora.org>
 <20160321103507.GB17326@leverpostej>
 <09ca2b70ae43432623cfbac374da1784@codeaurora.org>
 <56F26FF1.90002@arm.com>
 <f33a9ea23bf426c138a9323e53703259@codeaurora.org>
Message-ID: <20160323144611.GB6344@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 08:36:14AM -0400, agustinv at codeaurora.org wrote:

> ACPI events *are* existing abstractions within ACPI-based systems and the
> mechanism works across OSes.

Correction; it never works anywhere. Its a nice idea on paper, but when
you're stuck with a firmware that hands you random values pulled from a
crack monkey's behind you have to then hack around, you wish you had
done the sane thing and stuffed it in code you can actually fix.
