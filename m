From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu,  9 Mar 2017 13:27:40 +0000
Subject: [v3 1/5] coresight: bindings for debug module
In-Reply-To: <1488520809-31670-2-git-send-email-leo.yan@linaro.org>
References: <1488520809-31670-2-git-send-email-leo.yan@linaro.org>
Message-ID: <1489066060-3513-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To be honest, coresight-debug sounds too generic and could be confusing with lot
of the other components. To be precise, the area is for External Debug to a CPU.
So "arm,coresight-cpu-debug" or even "arm,coresight-cpu-external-debug" sounds
more appropriate to me.

Suzuki
