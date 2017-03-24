From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 24 Mar 2017 15:23:36 +0100
Subject: [PATCH v3 1/4] gpio: mvebu: Add limited PWM support
In-Reply-To: <20170324141815.7252-2-ralph.sennhauser@gmail.com>
References: <20170324141815.7252-1-ralph.sennhauser@gmail.com>
 <20170324141815.7252-2-ralph.sennhauser@gmail.com>
Message-ID: <20170324142336.GI28518@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ralph

> +- #pwm-cells: Should be one. The first cell is the pin number.

> +			#pwm-cells = <2>;

You missed updating the example.
