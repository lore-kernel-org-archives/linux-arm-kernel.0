From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 28 Aug 2013 13:58:13 +0200
Subject: [PATCH v5] gpio: pcf857x: Add OF support
In-Reply-To: <20130827171854.GA2988@katana>
References: <1377590559-14279-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2400176.9Vcd5TUYl9@avalon> <20130827171854.GA2988@katana>
Message-ID: <7583101.2yAsZLOucV@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 August 2013 19:18:55 Wolfram Sang wrote:
> > The driver should support the same chip models reardless of whether it's
> > used with or without DT. If an entry in the OF table has no corresponding
> > entry in the I2C table I would consider that as a driver bug.
> 
> Linus Walleij posted a patch to support DT only probing, but too many
> side-effects showed up. Some were fixable (probe regressions) and some
> need more work, if feasible at all. Most prominent is that runtime
> instantiation of i2c slaves currently needs an entry in the i2c table.

Linus, I'd like to get this in v3.12 if it's not too late. Could you please 
provide your input ?

-- 
Regards,

Laurent Pinchart
