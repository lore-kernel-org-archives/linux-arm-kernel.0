From: robh@kernel.org (Rob Herring)
Date: Wed, 25 Jul 2018 10:02:23 -0600
Subject: [PATCH v2 2/2] Input: atmel_mxt_ts: Document optional voltage
 regulators
In-Reply-To: <1531851386-17840-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1531851386-17840-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1531851386-17840-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Message-ID: <20180725160223.GA19907@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 08:16:26PM +0200, Pawe? Chmiel wrote:
> Document new optional voltage regulators, which can be used
> to power down/up touchscreen.
> 
> Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  Documentation/devicetree/bindings/input/atmel,maxtouch.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
