From: robh@kernel.org (Rob Herring)
Date: Tue, 7 Aug 2018 11:48:35 -0600
Subject: [PATCH v2 01/10] dt-bindings: clock: Add syscon support to
 Actions Semi Owl SoCs
In-Reply-To: <20180801033915.15880-2-manivannan.sadhasivam@linaro.org>
References: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
 <20180801033915.15880-2-manivannan.sadhasivam@linaro.org>
Message-ID: <20180807174835.GA13777@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2018 at 09:09:06AM +0530, Manivannan Sadhasivam wrote:
> Since the clock and reset management units are sharing the same memory
> map, document the clock bindings to support System Controller.

This is no reason to add child nodes. The existing node can be both a 
clock and reset provider.

> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/clock/actions,owl-cmu.txt        | 21 +++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
