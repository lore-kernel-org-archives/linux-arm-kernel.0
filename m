From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 14 Apr 2016 18:05:17 +0100
Subject: [PATCH V2 02/15] coresight: tmc: waiting for TMCReady bit before
 programming
In-Reply-To: <1460483692-25061-3-git-send-email-mathieu.poirier@linaro.org>
References: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
 <1460483692-25061-3-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <570FCDCD.1060902@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/16 18:54, Mathieu Poirier wrote:
> According to the TRM before programming the TMC in circular
> buffer mode (and that for any configuration, ETB, ETR, ETF),
> the TMCReady bit in the status register has to be set.
>
> This patch adds a check to make sure the state machine is in
> a state where it can be configured, and complains otherwise.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Suzuki
