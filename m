From: robh@kernel.org (Rob Herring)
Date: Fri, 13 Apr 2018 12:18:53 -0500
Subject: [PATCH 1/3] dt-bindings: interrupt-controller: fix the double
 quotes
In-Reply-To: <20180408145700.23520-2-yixun.lan@amlogic.com>
References: <20180408145700.23520-1-yixun.lan@amlogic.com>
 <20180408145700.23520-2-yixun.lan@amlogic.com>
Message-ID: <20180413171853.5blruiakambnzsgr@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 08, 2018 at 02:56:58PM +0000, Yixun Lan wrote:
> The double quotes seems not ASCII type, fix it here.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  .../bindings/interrupt-controller/amlogic,meson-gpio-intc.txt  | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
