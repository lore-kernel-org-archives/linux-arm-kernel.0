From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 30 Sep 2014 10:31:22 -0700
Subject: [PATCH v7 3/7] arm: dts: qcom: Add SPM device bindings for 8084
In-Reply-To: <1411779495-39724-4-git-send-email-lina.iyer@linaro.org> (Lina
 Iyer's message of "Fri, 26 Sep 2014 18:58:11 -0600")
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
 <1411779495-39724-4-git-send-email-lina.iyer@linaro.org>
Message-ID: <7hd2ad10d1.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lina Iyer <lina.iyer@linaro.org> writes:

> Add SPM device bindings for QCOM 8084 based cpus. SPM is the sub-system
> power manager and controls the logic around the cores (cpu and L2).
>
> Each core has an instance of SPM and controls only that core. Each cpu
> SPM is configured to support WFI and SPC (standalone-power collapse).
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

nit: This will need some more description, IMO.  The changelog talks
about SPM bindings, but all the stuff added refers to SAW.

Kevin
