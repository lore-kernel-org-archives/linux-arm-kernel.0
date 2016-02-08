From: robh@kernel.org (Rob Herring)
Date: Mon, 8 Feb 2016 15:24:43 -0600
Subject: [PATCH V5 1/2] regulator: Add document for MT6323 regulator
In-Reply-To: <1454874037-38905-1-git-send-email-blogic@openwrt.org>
References: <1454874037-38905-1-git-send-email-blogic@openwrt.org>
Message-ID: <20160208212443.GA32296@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 07, 2016 at 08:40:36PM +0100, John Crispin wrote:
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: devicetree at vger.kernel.org
> 
> ---
> Changes in V5
> * regulator vs regulators
> 
> Changes in V4
> * regulator is a subnode and not a property
> 
>  .../bindings/regulator/mt6323-regulator.txt        |  244 ++++++++++++++++++++
>  1 file changed, 244 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mt6323-regulator.txt

Acked-by: Rob Herring <robh@kernel.org>
