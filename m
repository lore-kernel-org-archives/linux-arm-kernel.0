From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 20 Oct 2014 14:38:02 -0700
Subject: [PATCH 1/3] drivers: cpuidle: add status property to ARM idle
 states
In-Reply-To: <1413467997-32131-1-git-send-email-lorenzo.pieralisi@arm.com>
 (Lorenzo Pieralisi's message of "Thu, 16 Oct 2014 14:59:55 +0100")
References: <1413467997-32131-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <7hbnp6e81x.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:

> On some platforms the device tree bindings must provide the kernel
> with a status flag for idle states, that defines whether the idle
> state is operational or not in the current configuration.
>
> This patch adds a status property to the ARM idle states compliant
> with ePAPR v1.1 and updates the DT parsing code accordingly.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

For the series:

Acked-by: Kevin Hilman <khilman@linaro.org>

Kevin
