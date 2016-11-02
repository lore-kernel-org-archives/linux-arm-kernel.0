From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 2 Nov 2016 20:24:14 +0200
Subject: [PATCH v7 RESEND 1/2] ASoC: samsung: Add DT bindings
 documentation for TM2 sound subsystem
In-Reply-To: <1478102558-12524-1-git-send-email-s.nawrocki@samsung.com>
References: <1478102558-12524-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20161102182414.GA7958@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2016 at 05:02:37PM +0100, Sylwester Nawrocki wrote:
> This patch adds DT binding documentation for Exnos5433 based TM2
> and TM2E boards sound subsystem.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes since v5:
>  - none.
> 
> Changes since v4:
>  - indentation changes.
> 
> Changes since v2:
>  - none.
> 
> Changes since initial version:
>  - dropped clocks, clock-names properties, instead properties from
>    the CODEC node will be used,
>  - property renames: 'samsung,model' -> 'model', 'samsung,i2s-controller'
>    -> 'i2s-controller', 'samsung,speaker-amplifier' -> 'audio-amplifier',
>  - added 'audio-codec' property.
> ---
>  .../bindings/sound/samsung,tm2-audio.txt           | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
>


Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
