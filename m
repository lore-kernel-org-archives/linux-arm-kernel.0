From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 17 Jan 2017 18:30:47 +0100
Subject: [PATCH v2 7/8] ARM: dts: kirkwood-mv88f6281gtw-ge: Utilize new
 DSA binding
In-Reply-To: <20170105192957.14304-8-f.fainelli@gmail.com>
References: <20170105192957.14304-1-f.fainelli@gmail.com>
 <20170105192957.14304-8-f.fainelli@gmail.com>
Message-ID: <20170117173047.GF9470@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 11:29:56AM -0800, Florian Fainelli wrote:
> Utilize the new DSA binding, introduced with commit 8c5ad1d6179d ("net: dsa:
> Document new binding"). The legacy binding node is kept included, but is marked
> disabled.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
