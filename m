From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 7 Dec 2012 21:28:45 +0000
Subject: [PATCH 0/6 v10] gpio: Add block GPIO
In-Reply-To: <50C22868.4070405@antcom.de>
References: <1354830456-17590-1-git-send-email-stigge@antcom.de>
 <20121207103643.34ca6dc5@pyramind.ukuu.org.uk>
 <50C1DBD4.1040007@antcom.de> <50C1DE21.8050709@antcom.de>
 <20121207170215.0057f791@pyramind.ukuu.org.uk>
 <50C22868.4070405@antcom.de>
Message-ID: <20121207212845.1500ca25@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> In the extreme case, define blocks with only a single GPIO in each of
> them, and the interface should still be faster than the sysfs one. Each
> block is a separate device node with separate permissions.

Ok, so it degenerates to the same case if needed. It's not ideal but I
have no suggestions how to improve it!
