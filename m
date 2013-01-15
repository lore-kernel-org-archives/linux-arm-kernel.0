From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 15 Jan 2013 13:49:05 +0000
Subject: [PATCH 12/26] mfd: ab8500-debugfs: Use NULL to initialise
 remaining NULL pointer
In-Reply-To: <20130115130635.GH5701@opensource.wolfsonmicro.com>
References: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
 <1358254566-12419-13-git-send-email-lee.jones@linaro.org>
 <20130115130635.GH5701@opensource.wolfsonmicro.com>
Message-ID: <20130115134905.GA9379@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Jan 2013, Mark Brown wrote:

> On Tue, Jan 15, 2013 at 12:55:52PM +0000, Lee Jones wrote:
> > Partly for coding style reasons, but mostly because sparse warns on it.
> > 
> > This patch is a completion of a previous patch my Mark Brown.
> 
> Typo there :)

Yes, it should say "patch by my Mark Brown". ;)

> Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Thanks. I'll fixup with the typo.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
