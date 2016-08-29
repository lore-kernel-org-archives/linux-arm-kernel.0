From: robh@kernel.org (Rob Herring)
Date: Sun, 28 Aug 2016 19:37:25 -0500
Subject: [PATCH] dt-bindings: touchscreen: silead_gsl1680: Document
 touchscreen-fw-name
In-Reply-To: <1471964688-12188-1-git-send-email-hdegoede@redhat.com>
References: <1471964688-12188-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160829003725.GA20749@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 05:04:48PM +0200, Hans de Goede wrote:
> The driver has supported touchscreen-fw-name to specify the firmware to
> load since day 0, but this was omitted from the binding, document this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt | 1 +
>  1 file changed, 1 insertion(+)

I'd really like to deprecate in favor of a standard property name. We've 
somewhat agreed on 'firmware-name' though there is no common binding doc 
yet. But given this is in use:

Acked-by: Rob Herring <robh@kernel.org>
