From: robh@kernel.org (Rob Herring)
Date: Mon, 11 Jul 2016 09:30:25 -0500
Subject: [PATCH 1/3] dt/bindings: Add bindings for JC-42.4 compatible
 temperature sensors
In-Reply-To: <1467737073-7949-1-git-send-email-linux@roeck-us.net>
References: <1467737073-7949-1-git-send-email-linux@roeck-us.net>
Message-ID: <20160711143025.GA6312@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2016 at 09:44:31AM -0700, Guenter Roeck wrote:
> Provide generic bindings for all Jedec JC-42.4 compatible temperature
> sensor chips.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/devicetree/bindings/hwmon/jc42.txt | 42 ++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/jc42.txt

Acked-by: Rob Herring <robh@kernel.org>
