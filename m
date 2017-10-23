From: robh@kernel.org (Rob Herring)
Date: Mon, 23 Oct 2017 17:44:47 -0500
Subject: [PATCH 1/4] dt-bindings: display: amlogic, meson-vpu: Add
 optional power domain property
In-Reply-To: <1508227664-11171-2-git-send-email-narmstrong@baylibre.com>
References: <1508227664-11171-1-git-send-email-narmstrong@baylibre.com>
 <1508227664-11171-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <20171023224447.3elnyvq7j44l55id@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 10:07:41AM +0200, Neil Armstrong wrote:
> The Video Processing Unit power domain was setup by the Vendor U-Boot,
> add support for an optional Power Domain phandle to setup it from the kernel.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Rob Herring <robh@kernel.org> 
