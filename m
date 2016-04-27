From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 27 Apr 2016 10:17:14 +0100
Subject: [PATCH V4 14/18] coresight: tmc: keep track of memory width
In-Reply-To: <1461708634-6327-15-git-send-email-mathieu.poirier@linaro.org>
References: <1461708634-6327-1-git-send-email-mathieu.poirier@linaro.org>
 <1461708634-6327-15-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <5720839A.1040402@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/04/16 23:10, Mathieu Poirier wrote:
> Accessing the HW configuration register each time the memory
> width is needed simply doesn't make sense.  It is much more
> efficient to read the value once and keep a reference for
> later use.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
