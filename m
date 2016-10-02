From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 2 Oct 2016 09:19:03 +0200
Subject: [PATCH] ARM: dts: vf610-zii-dev-rev-b: Remove I2C3
In-Reply-To: <1475371719-28736-1-git-send-email-andrew.smirnov@gmail.com>
References: <1475371719-28736-1-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <20161002071903.GD5304@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 01, 2016 at 06:28:39PM -0700, Andrey Smirnov wrote:
> I2C3 bus was only brought out in revision A1 of the board and revision
> B1 only brings out 3 I2C busses (I2C0, I2C1 and I2C2).
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
