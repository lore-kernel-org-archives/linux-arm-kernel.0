From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 14 Mar 2011 00:15:53 +0200
Subject: [PATCH v2 2/8] ARM: PXA: Z2: Enable OHCI on Zipit Z2
In-Reply-To: <201103131934.02152.marek.vasut@gmail.com>
References: <1299839023-16601-2-git-send-email-anarsoul@gmail.com>
	<20110313171033.GA1413@ucw.cz>
	<201103131934.02152.marek.vasut@gmail.com>
Message-ID: <201103140015.53418.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 13 March 2011 20:34:02 Marek Vasut wrote:

> Actually it does ... how to connect the USB UDC is under Aeronix NDA (even
> the fact the UHC pins are on the connector is under NDA ;-) )

Actually, it was reverse-engineered by someone from zipit community, he 
removed BGA chips and traced CPU pins to external connector. So there's 
connector pinout that does not require NDA :)
