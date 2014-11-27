From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 27 Nov 2014 11:38:20 +0000
Subject: [PATCH v3 1/5] Documentation: DT: Renamed of-serial.txt to
 8250.txt
In-Reply-To: <1416917818-10506-2-git-send-email-chunyan.zhang@spreadtrum.com>
References: <Sharkl64-v3>
 <1416917818-10506-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1416917818-10506-2-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <20141127113819.GD857@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 12:16:54PM +0000, Chunyan Zhang wrote:
> The file of-serial.txt was only for 8250 compatible UART implementations,
> so renamed it to 8250.txt to avoid confusing other persons.
> This is recommended by Arnd, see:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/291455.html
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>

My prior Ack [1] still applies (given you've just changed the way the
patch was generated, as Arnd and I suggested).

Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/295152.html

> ---
>  .../bindings/serial/{of-serial.txt => 8250.txt}    |    0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/serial/{of-serial.txt => 8250.txt} (100%)
> 
> diff --git a/Documentation/devicetree/bindings/serial/of-serial.txt b/Documentation/devicetree/bindings/serial/8250.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/serial/of-serial.txt
> rename to Documentation/devicetree/bindings/serial/8250.txt
> -- 
> 1.7.9.5
> 
> 
