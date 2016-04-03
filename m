From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 3 Apr 2016 16:05:34 +0200
Subject: [PATCH 0/8] Various Kirkwood DT warning fixup
In-Reply-To: <8737r2sxwm.fsf@free-electrons.com>
References: <1459649030-21886-1-git-send-email-andrew@lunn.ch>
 <8737r2sxwm.fsf@free-electrons.com>
Message-ID: <20160403140534.GA22003@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Could you tell me more about the comparison you did?

Hi Gregory

I used dtc -o foo.dts -O dts -I dtb foo.dtb to turn the generated
binary blob back into ascii and then used diff.

       Andrew 
