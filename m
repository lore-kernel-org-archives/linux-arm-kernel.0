From: robh@kernel.org (Rob Herring)
Date: Fri, 27 Apr 2018 09:35:50 -0500
Subject: [PATCH v4 1/7] dt-bindings: display: Document the EDT et*
 displays in one file.
In-Reply-To: <20180427132445.3458-2-jan.tuerk@emtrion.com>
References: <20180420125108.14197-1-jan.tuerk@emtrion.com>
 <20180427132445.3458-1-jan.tuerk@emtrion.com>
 <20180427132445.3458-2-jan.tuerk@emtrion.com>
Message-ID: <20180427143550.yzc3rnunjeudevhi@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 03:24:36PM +0200, jan.tuerk at emtrion.com wrote:
> From: Jan Tuerk <jan.tuerk@emtrion.com>
> 
> Document the Emerging Display Technology Corp. (EDT) using the
> simple-panel binding in one single file.
> 
> Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
> ---
> Changes for v4:
>   - re-arrange the Patch-series to match the DT-submitting-patches
>   - Additional patch for the Documentation of the new DT-bindings
>   - no change (re-arranged 3/6 => 1/7)
> 
>  .../bindings/display/panel/edt,et-series.txt       | 39 ++++++++++++++++++++++
>  .../bindings/display/panel/edt,et057090dhu.txt     |  7 ----
>  .../bindings/display/panel/edt,et070080dh6.txt     | 10 ------
>  .../bindings/display/panel/edt,etm0700g0dh6.txt    | 10 ------
>  4 files changed, 39 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/edt,et-series.txt
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,et057090dhu.txt
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,et070080dh6.txt
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,etm0700g0dh6.txt

Reviewed-by: Rob Herring <robh@kernel.org>
