From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Mon, 14 Apr 2014 11:57:58 +0100
Subject: [PATCH v4 2/2] reset: Add GPIO support to reset controller
 framework
In-Reply-To: <1397463709-19405-2-git-send-email-p.zabel@pengutronix.de>
References: <1397463709-19405-1-git-send-email-p.zabel@pengutronix.de>
 <1397463709-19405-2-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20140414115758.2c0c8a9d@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This adds support for GPIO controlled reset pins on peripheral ICs to the reset
> controller framework. Currently there is no support for specifying a delay
> between assertion and de-assertion of the reset signal, so this has to be
> handled by the drivers.

Lots of GPIO controllers are doing posted writes to the fabric so surely
your delay will be wrong ?


Alan
