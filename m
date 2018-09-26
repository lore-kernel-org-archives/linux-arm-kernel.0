From: robh@kernel.org (Rob Herring)
Date: Wed, 26 Sep 2018 17:51:50 -0500
Subject: [PATCH v2 1/4] dt-bindings: mrvl,mmp-timer: add clock
In-Reply-To: <20180918205455.25464-2-lkundrak@v3.sk>
References: <20180918205455.25464-1-lkundrak@v3.sk>
 <20180918205455.25464-2-lkundrak@v3.sk>
Message-ID: <20180926225150.GA15157@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Sep 2018 22:54:52 +0200, Lubomir Rintel wrote:
> The timer needs the timer clock to be enabled, otherwise it stops
> ticking.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v1:
> - Made the clock optional, to keep compatibility with DTs without it
> 
>  Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
