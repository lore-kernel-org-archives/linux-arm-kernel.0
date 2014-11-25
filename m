From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Tue, 25 Nov 2014 20:16:54 +0800
Subject: [PATCH v3 1/5] Documentation: DT: Renamed of-serial.txt to 8250.txt
In-Reply-To: <1416917818-10506-1-git-send-email-chunyan.zhang@spreadtrum.com>
References: <Sharkl64-v3>
 <1416917818-10506-1-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <1416917818-10506-2-git-send-email-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The file of-serial.txt was only for 8250 compatible UART implementations,
so renamed it to 8250.txt to avoid confusing other persons.
This is recommended by Arnd, see:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/291455.html

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 .../bindings/serial/{of-serial.txt => 8250.txt}    |    0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/serial/{of-serial.txt => 8250.txt} (100%)

diff --git a/Documentation/devicetree/bindings/serial/of-serial.txt b/Documentation/devicetree/bindings/serial/8250.txt
similarity index 100%
rename from Documentation/devicetree/bindings/serial/of-serial.txt
rename to Documentation/devicetree/bindings/serial/8250.txt
-- 
1.7.9.5
