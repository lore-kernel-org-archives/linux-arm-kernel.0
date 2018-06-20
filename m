From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 20 Jun 2018 20:47:47 +0200
Subject: [PATCH] dt-bindings: arm: Remove obsolete insignal-boards.txt
In-Reply-To: <20180531165007.GA29098@rob-hp-laptop>
References: <20180528185310.21971-1-krzk@kernel.org>
 <20180531165007.GA29098@rob-hp-laptop>
Message-ID: <20180620184747.ermfvtqzllofwoub@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2018 at 11:50:07AM -0500, Rob Herring wrote:
> On Mon, May 28, 2018 at 08:53:10PM +0200, Krzysztof Kozlowski wrote:
> > The compatibles mentioned in insignal-boards.txt are already documented
> > under devicetree/bindings/arm/samsung/samsung-boards.txt.  Also the
> > contents of insignal-boards.txt is not accurate, e.g. does not mention
> > Arndale boards.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/arm/insignal-boards.txt | 8 --------
> >  1 file changed, 8 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/insignal-boards.txt
> 
> Reviewd-by: Rob Herring <robh@kernel.org>

Applied to samsung-soc (with fixed typo for Reviewed-by tag).

Best regards,
Krzysztof
