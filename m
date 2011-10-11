From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 11 Oct 2011 19:28:06 +0200
Subject: [RFC PATCH] tty/serial: RS485 bindings for device tree
In-Reply-To: <1318353208-24422-1-git-send-email-nicolas.ferre@atmel.com>
References: <1318353208-24422-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <4E947CA6.9010703@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I can also add this new property (support for it already in linux-next):

On 10/11/2011 07:13 PM, Nicolas Ferre :
> Generic bindings for RS485 feature included in some UARTs.
> Those bindings have to be used withing an UART device tree node.
> Documentation updated to link to the bindings definition.

[..]

> +Optional properties:
> +- linux,rs485-enabled-at-boot-time: empty property telling to enable the rs485
> +  feature at boot time. It can be disabled later with proper ioctl.

+- linux,rs485-rx-during-tx: empty property that enable the receiving of data
+  even whilst sending data.

> +- linux,rs485-rts-delay: prop-encoded-array <a b> where:

[..]

Best regards,
-- 
Nicolas Ferre
