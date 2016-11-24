From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 24 Nov 2016 16:48:58 +0100
Subject: [net-next PATCH v1 1/2] net: dt-bindings: add RGMII TX delay
 configuration to meson8b-dwmac
In-Reply-To: <20161124143417.10178-2-martin.blumenstingl@googlemail.com>
References: <20161124143417.10178-1-martin.blumenstingl@googlemail.com>
 <20161124143417.10178-2-martin.blumenstingl@googlemail.com>
Message-ID: <20161124154858.GB20455@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The configuration values are provided as preprocessor macros to make the
> devicetree files easier to read.

Hi Martin

If i'm reading the code/comments correctly, you can set the delay to
0, 2, 4 or 6ns? So calling this property amlogic,tx-delay-ns would be
even easier to read.

     Andrew
