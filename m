From: ccc94453@vip.cybercity.dk (Rask Ingemann Lambertsen)
Date: Sun, 28 Aug 2016 21:13:53 +0200
Subject: [PATCH 2/2] ARM64: dts: meson-gxbb: add the SDIO pins
In-Reply-To: <20160828164725.19429-3-martin.blumenstingl@googlemail.com>
References: <20160828164725.19429-1-martin.blumenstingl@googlemail.com>
 <20160828164725.19429-3-martin.blumenstingl@googlemail.com>
Message-ID: <20160828191353.wpwbqsxdg5pdmese@vip.cybercity.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 28, 2016 at 06:47:25PM +0200, Martin Blumenstingl wrote:
>  				uart_a_pins: uart_a {
>  					mux {
>  						groups = "uart_tx_a",

You shouldn't use underscores in node names. Use hyphens instead, perhaps.
https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1122967.html
https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1145633.html

-- 
Rask Ingemann Lambertsen
