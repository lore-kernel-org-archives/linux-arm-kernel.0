From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Fri, 16 Jan 2015 18:00:07 +0800
Subject: [PATCH v5 1/5] Documentation: DT: Renamed of-serial.txt to 8250.txt
In-Reply-To: <1421402411-3479-1-git-send-email-chunyan.zhang@spreadtrum.com>
References: <sc9836-v5>
 <1421402411-3479-1-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <1421402411-3479-2-git-send-email-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The file of-serial.txt was only for 8250 compatible UART implementations,
so renamed it to 8250.txt to avoid confusing other persons.
This is suggested by Arnd, see:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/291455.html

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
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
