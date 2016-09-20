From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 20 Sep 2016 19:26:31 +0200
Subject: [PATCH v3] ASoC: exynos: organize the asoc audio into a menu
In-Reply-To: <1474311470-23175-1-git-send-email-ayaka@soulik.info>
References: <1474311470-23175-1-git-send-email-ayaka@soulik.info>
Message-ID: <20160920172631.GA17304@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2016 at 02:57:50AM +0800, Randy Li wrote:
> It is simple sound card time, we could assign different codec
> to a interface without making a specific driver for it. The SPDIF
> and I2S interface for Samsung would be possible used by
> simple-sound-card, but not sure about the PCM.
> 
> Those S3C time entries are left alone as I don't think any new board
> would need them.
> 
> Signed-off-by: Randy Li <ayaka@soulik.info>
> ---
>  sound/soc/samsung/Kconfig | 57 ++++++++++++++++++++++++-----------------------
>  1 file changed, 29 insertions(+), 28 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
