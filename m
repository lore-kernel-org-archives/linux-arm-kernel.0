From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 14 Apr 2016 18:01:12 +0100
Subject: [PATCH V2 01/15] coresight: tmc: modifying naming convention
In-Reply-To: <1460483692-25061-2-git-send-email-mathieu.poirier@linaro.org>
References: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
 <1460483692-25061-2-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <570FCCD8.5060402@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/16 18:54, Mathieu Poirier wrote:
> According to the TMC architectural state machine, the 'stopped'
> state is reached when bit 2 (TMCReady) of the TMC Status register
> turns to '1'.  The code is correct but the naming convention isn't.
>
> The 'Triggered' bit occupies position '1' of the TMC Status register
> and has nothing to do with the indication of the TMC entering the
> stopped state. As such renaming function "tmc_wait_for_triggered()"
> and changing the #define to reflect what the code is really doing.
>
> This patch has no effect other than clarifying the semantic.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Suzuki
