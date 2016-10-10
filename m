From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Oct 2016 07:59:46 -0500
Subject: [RESEND PATCH v2 3/3] dt-bindings: reset: oxnas: Update for OX820
In-Reply-To: <20161005152710.2898-4-narmstrong@baylibre.com>
References: <20161005152710.2898-1-narmstrong@baylibre.com>
 <20161005152710.2898-4-narmstrong@baylibre.com>
Message-ID: <20161010125946.GA31343@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 05, 2016 at 05:27:10PM +0200, Neil Armstrong wrote:
> Add new compatible string for reset and sys-ctrl for the Oxford
> Semiconductor OX820 Support.
> Drop the OX810SE indices since they moved in a dedicated include file.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/reset/oxnas,reset.txt      | 44 +++++-----------------
>  1 file changed, 9 insertions(+), 35 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
