From: robh@kernel.org (Rob Herring)
Date: Wed, 8 Feb 2017 15:17:55 -0600
Subject: [PATCH v4 06/10] dt-bindings: serial: Update 'uart-has-rtscts'
 description
In-Reply-To: <20170203102319.23489-7-lee.jones@linaro.org>
References: <20170203102319.23489-1-lee.jones@linaro.org>
 <20170203102319.23489-7-lee.jones@linaro.org>
Message-ID: <20170208211755.gcghb332q5dt2alt@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 03, 2017 at 10:23:15AM +0000, Lee Jones wrote:
> 'uart-has-rtscts' property and 'rts-gpios|cts-gpios' are normally
> mutually exclusive, however it is possible for some drivers to have
> a dynamic approach, meaning that both properties can be relevant.
> 
> Acked-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  Documentation/devicetree/bindings/serial/serial.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thought I acked this...

Acked-by: Rob Herring <robh@kernel.org>
