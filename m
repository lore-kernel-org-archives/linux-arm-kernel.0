From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 16 Oct 2012 14:14:52 +0900
Subject: [PATCH 1/2] ASoC: Ux500: Dispose of device nodes correctly
In-Reply-To: <1350306806-5688-1-git-send-email-lee.jones@linaro.org>
References: <1350306806-5688-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20121016051444.GC8670@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2012 at 02:13:25PM +0100, Lee Jones wrote:
> When of_parse_phandle() is used to find a device node, its
> reference count is incremented by the helper. Once we're
> finished with them, it's our responsibly to ensure they
> are freed in the correct manor.

Applied both, thanks.
