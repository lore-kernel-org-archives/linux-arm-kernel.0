From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 30 Mar 2017 11:15:04 -0600
Subject: [PATCH v2 0/2] coresight: Allow sharing of STM
In-Reply-To: <1490805215-8125-1-git-send-email-suzuki.poulose@arm.com>
References: <1490805215-8125-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <CANLsYkxOnwDRmWKFYwvE=z6KayYpDnXMX=ZuGquQspoBtLgR2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 March 2017 at 10:33, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> This series fixes the coresight generic layer to handle the reference
> counting for the STM source properly, to allow multiple applications
> to share the STM. Without this series, the STM is disabled when the
> first user closes its connection, causing trace data losses.
>
>
> Changes since v1:
>   - Fixed minor coding style issues
>
> Suzuki K Poulose (2):
>   coresight: Disable the path only when the source is disabled
>   coresight: Fix reference count for software sources
>
>  drivers/hwtracing/coresight/coresight.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)

Applied - thanks,
Mathieu

>
> --
> 2.7.4
>
