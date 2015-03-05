From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 05 Mar 2015 11:42:10 -0800
Subject: [PATCH v2 1/3] devicetree: bindings: Document qcom,
 msm-id and qcom, board-id
In-Reply-To: <1425503602-24916-1-git-send-email-galak@codeaurora.org> (Kumar
 Gala's message of "Wed, 4 Mar 2015 15:13:20 -0600")
References: <1425503602-24916-1-git-send-email-galak@codeaurora.org>
Message-ID: <7h8ufbjkod.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kumar Gala <galak@codeaurora.org> writes:

> The top level qcom,msm-id and qcom,board-id are utilized by bootloaders
> on Qualcomm MSM platforms to determine which device tree should be
> utilized and passed to the kernel.
>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Kumar Gala <galak@codeaurora.org>

Is this the special magic that allows qcom bootloaders to take a kernel
plus multiple DTBs and figure out which DTB to pass?

Kevin
