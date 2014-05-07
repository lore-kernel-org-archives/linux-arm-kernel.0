From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 May 2014 09:53:31 -0700
Subject: [PATCH v5 13/14] ARM: dts: Add PMU support in HiP04
In-Reply-To: <1399473888-12947-14-git-send-email-haojian.zhuang@linaro.org>
References: <1399473888-12947-1-git-send-email-haojian.zhuang@linaro.org>
 <1399473888-12947-14-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140507165331.GE12692@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 07, 2014 at 10:44:47PM +0800, Haojian Zhuang wrote:
> From: Kefeng Wang <kefeng.wang@linaro.org>
> 
> ARM Performance Monitor Units are available on the HiP04.
> So add the support in the dtsi.
> 
> Simply tested with perf.
> 
> Signed-off-by: Kefeng Wang <kefeng.wang@linaro.org>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

This should be squashed into the original dts introduction patch, no need
to add these separately.


-Olof
