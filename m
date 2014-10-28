From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Oct 2014 22:11:48 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: fix support for APQ8084
In-Reply-To: <1413917720-17069-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1413917720-17069-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <15749942.RHYUJy9s6B@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 October 2014 19:55:20 Srinivas Kandagatla wrote:
> This patch enables configs required to boot IFC6540 board with atleast a
> serial console.
> 
> Without this patch there is no serial console.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 

It wasn't really clear from your email what you expected to happen with this
patch. I've picked it up in the fixes branch for 3.18 now, as it seemed
to fit that category.

	Arnd
