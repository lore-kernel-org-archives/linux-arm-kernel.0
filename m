From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 4 Feb 2013 09:19:43 -0500
Subject: [PATCH v3 2/4] ARM: Kirkwood: Add support thermal sensor for
 88F6282 and 88F6283
In-Reply-To: <1359947693.2250.50.camel@rzhang1-mobl4>
References: <1359815749-27705-1-git-send-email-andrew@lunn.ch>
 <1359815749-27705-3-git-send-email-andrew@lunn.ch>
 <1359947693.2250.50.camel@rzhang1-mobl4>
Message-ID: <20130204141943.GL14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 11:14:53AM +0800, Zhang Rui wrote:
> On Sat, 2013-02-02 at 15:35 +0100, Andrew Lunn wrote:
> > From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > 
> > Kirkwood 88F6282 and 88F6283 have a thermal sensor.
> > This patch adds a DT node and enables the driver in the kernel config.
> > 
> > Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> I can take this one but I need ACK from ARM experts first.

If you don't mind, I prefer to take patches 2 and 4.  If you could take
1 and 3 and let me know what tree/branch you place them in, then I'll
depend on them when I push them up.

thx,

Jason.
