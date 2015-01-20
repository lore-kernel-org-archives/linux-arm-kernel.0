From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Tue, 20 Jan 2015 22:42:20 +0000
Subject: [PATCH] efi: don't look for chosen@0 node on DT platforms
In-Reply-To: <1421771678-31812-1-git-send-email-leif.lindholm@linaro.org>
References: <1421771678-31812-1-git-send-email-leif.lindholm@linaro.org>
Message-ID: <20150120224220.GD12079@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Jan, at 04:34:38PM, Leif Lindholm wrote:
> Due to some scary special case handling noticed in drivers/of, various
> bits of the ARM* EFI support patches did duplicate looking for @0
> variants of various nodes. Unless on an ancient PPC system, these are
> not in fact required. Most instances have become refactored out along
> the way, this removes the last one.
> 
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> ---
>  drivers/firmware/efi/efi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Thanks Leif. Applied for v3.20.

-- 
Matt Fleming, Intel Open Source Technology Center
