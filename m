From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 May 2014 09:52:41 -0700
Subject: [PATCH v5 10/14] ARM: config: append hip04_defconfig
In-Reply-To: <1399473888-12947-11-git-send-email-haojian.zhuang@linaro.org>
References: <1399473888-12947-1-git-send-email-haojian.zhuang@linaro.org>
 <1399473888-12947-11-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140507165241.GD12692@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 07, 2014 at 10:44:44PM +0800, Haojian Zhuang wrote:
> Select HiP04 SoC configuration by hip04_defconfig.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

We're letting each vendor have one defconfig. This should coexist and/or add to
the hi3xxx defconfig instead of creating a new one.


-Olof
