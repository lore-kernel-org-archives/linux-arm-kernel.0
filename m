From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 17 Jan 2017 18:28:14 +0100
Subject: [PATCH v2 4/8] ARM: dts: armada-xp-linksys-mamba: Utilize new
 DSA binding
In-Reply-To: <20170105192957.14304-5-f.fainelli@gmail.com>
References: <20170105192957.14304-1-f.fainelli@gmail.com>
 <20170105192957.14304-5-f.fainelli@gmail.com>
Message-ID: <20170117172814.GD9470@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 11:29:53AM -0800, Florian Fainelli wrote:
> Utilize the new DSA binding, introduced with commit 8c5ad1d6179d ("net: dsa:
> Document new binding"). The legacy binding node is kept included, but is marked
> disabled.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Tested-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
