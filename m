From: a.p.zijlstra@chello.nl (Peter Zijlstra)
Date: Mon, 09 Jul 2012 13:00:12 +0200
Subject: [PATCH v4 3/5] ARM: topology: Update cpu_power according to DT
 information
In-Reply-To: <CAMQu2gydOEVK_fzmzkdrBwBfOq6eZG=0QfLUfFChWJu9unSn2A@mail.gmail.com>
References: <1341826026-6504-1-git-send-email-vincent.guittot@linaro.org>
 <1341826026-6504-4-git-send-email-vincent.guittot@linaro.org>
 <CAMQu2gydOEVK_fzmzkdrBwBfOq6eZG=0QfLUfFChWJu9unSn2A@mail.gmail.com>
Message-ID: <1341831612.3462.29.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-07-09 at 16:25 +0530, Shilimkar, Santosh wrote:
> Having that support would greatly help for the SOC's which have not
> yet
> reached to stage where entire SOC is DT compliant and want to use
> big.LITTLE infrastructure. 

Good incentive to get there though.. :-)
