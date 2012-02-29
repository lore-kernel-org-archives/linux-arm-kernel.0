From: jason@lakedaemon.net (Jason)
Date: Wed, 29 Feb 2012 09:44:50 -0500
Subject: [PATCH 2/3 v4] arm: kirkwood: add dreamplug (fdt) support.
In-Reply-To: <20120224075753.GA24858@lunn.ch>
References: <20120224075753.GA24858@lunn.ch>
Message-ID: <20120229144450.GB23524@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Fri, Feb 24, 2012 at 08:57:53AM +0100, Andrew Lunn wrote:
> I have some patches under development which will help.

Any chance you could shoot those to me?  (on-list preferable)  I'm
thinking we could convert it to an interim solution eg
kirkwood_{get,put}_clock() that would be easy to migrate to generic
CLK/clkdev once it lands.

thx,

Jason.
