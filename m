From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Oct 2016 07:59:02 -0500
Subject: [PATCH 6/6] dt-bindings: clk: oxnas,stdclk: Add OX820 bindings
In-Reply-To: <20161005150752.22618-7-narmstrong@baylibre.com>
References: <20161005150752.22618-1-narmstrong@baylibre.com>
 <20161005150752.22618-7-narmstrong@baylibre.com>
Message-ID: <20161010125902.GA30591@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 05, 2016 at 05:07:52PM +0200, Neil Armstrong wrote:
> Add OX820 bindings and remove clock indices from bindings since they are present
> in the dt-bindings headers files.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/clock/oxnas,stdclk.txt        | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
