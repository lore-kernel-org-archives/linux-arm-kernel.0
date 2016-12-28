From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 28 Dec 2016 19:53:44 +0200
Subject: [PATCH 7/8] ARM: s3c64xx: Drop initialization of unused struct
 s3c_audio_pdata fields
In-Reply-To: <1478791076-19528-8-git-send-email-s.nawrocki@samsung.com>
References: <1478791076-19528-1-git-send-email-s.nawrocki@samsung.com>
 <1478791076-19528-8-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20161228175344.3krz2hqrem56ypg6@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 04:17:55PM +0100, Sylwester Nawrocki wrote:
> Remove initialization of dma_{filter, playback, capture, capture_mic}
> fields where it is not used any more.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/mach-s3c64xx/dev-audio.c | 19 -------------------
>  1 file changed, 19 deletions(-)
>

Sylwester,

This and 8/8 should be safe to apply, right?

BR,
Krzysztof
