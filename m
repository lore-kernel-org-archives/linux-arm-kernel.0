From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 6 Dec 2013 15:39:03 +0000
Subject: [PATCH v5 1/3] mfd: tps6586x: add version detection
In-Reply-To: <7812fb79beac0a6a409090f43d129893f9f93b5b.1386333697.git.stefan@agner.ch>
References: <cover.1386333697.git.stefan@agner.ch>
 <7812fb79beac0a6a409090f43d129893f9f93b5b.1386333697.git.stefan@agner.ch>
Message-ID: <20131206153903.GD23519@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 06 Dec 2013, Stefan Agner wrote:

> Use the VERSIONCRC to determine the exact device version. According to
> the datasheet this register can be used as device identifier. The
> identification is needed since some tps6586x regulators use a different
> voltage table.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Changes since v4:
>   - Use variable named version instead of ret
> 
> Changes since v2:
>   - Avoid moving devm_kzalloc
> ---
>  drivers/mfd/tps6586x.c       | 50 +++++++++++++++++++++++++++++++++++++-------
>  include/linux/mfd/tps6586x.h |  7 +++++++
>  2 files changed, 49 insertions(+), 8 deletions(-)

Applied with Acks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
