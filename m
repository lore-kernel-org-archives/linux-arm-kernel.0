From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 21 Jan 2016 09:56:21 -0700
Subject: [RESEND PATCH 0/2] Remove the mistakes detected by the check
 tools.
In-Reply-To: <cover.1453271738.git.eric.long@linaro.org>
References: <cover.1453271738.git.eric.long@linaro.org>
Message-ID: <CANLsYkzqFaPs2XbF0kC_jbG1=Jry2+bZMHMq-m9gUxMkoLAhnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 January 2016 at 23:39, Eric Long <eric.long@linaro.org> wrote:
> Both of the two patches optimize the code and remove the mistakes and
> warnings detected by the check tools.
>
> Eric Long (2):
>   coresight: tmc/etm4x: Remove the mistakes detected by sparse tool
>   coresight: Remove the mistakes detected by smatch tool
>
>  drivers/hwtracing/coresight/coresight-etm4x.c |    2 +-
>  drivers/hwtracing/coresight/coresight-tmc.c   |    6 +++---
>  drivers/hwtracing/coresight/of_coresight.c    |    2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>

Please run checkpath.pl on your patches.  Also if the changes are of a
different nature, ex. indentation problem and wrong argument to a
function, please provide two separate patches.

Thanks,
Mathieu

> --
> 1.7.9.5
>
