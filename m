From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 18 Jan 2017 13:57:14 +0100
Subject: [PATCH v3 8/8] ARM: dts: kirkwood-rd88f6281: Utilize new DSA
 binding
In-Reply-To: <20170117182224.32212-9-f.fainelli@gmail.com>
References: <20170117182224.32212-1-f.fainelli@gmail.com>
 <20170117182224.32212-9-f.fainelli@gmail.com>
Message-ID: <20170118125714.GD7690@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 10:22:24AM -0800, Florian Fainelli wrote:
> Utilize the new DSA binding, introduced with commit 8c5ad1d6179d ("net: dsa:
> Document new binding"). The legacy binding node is kept included, but is marked
> disabled.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
