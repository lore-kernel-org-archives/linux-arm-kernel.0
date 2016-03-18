From: robh@kernel.org (Rob Herring)
Date: Fri, 18 Mar 2016 16:30:31 -0500
Subject: [PATCH v4 7/8] Documentation: devicetree: rockchip: Document
 Landingship
In-Reply-To: <1458136727-32075-8-git-send-email-afaerber@suse.de>
References: <1458136727-32075-1-git-send-email-afaerber@suse.de>
 <1458136727-32075-8-git-send-email-afaerber@suse.de>
Message-ID: <20160318213031.GA10729@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2016 at 02:58:45PM +0100, Andreas F?rber wrote:
> Use "geekbuying,geekbox-landingship" compatible string, plus those of
> the GeekBox module.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v3 -> v4: Unchanged
>  
>  v2 -> v3:
>  * Changed compatible string to include geekbox- (Heiko)
>    and clarify that this is for GeekBox module
>  
>  v2: New
>  
>  Documentation/devicetree/bindings/arm/rockchip.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Think I already acked v3, but:

Acked-by: Rob Herring <robh@kernel.org>
