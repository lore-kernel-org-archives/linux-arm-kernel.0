From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 11 Jan 2012 12:30:25 +0000
Subject: tty/serial: Need clarification on Support for 4+M Baudrate
In-Reply-To: <20120111121901.GA4034@bnru05>
References: <20120111121901.GA4034@bnru05>
Message-ID: <20120111123025.244a9cf5@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Jan 2012 17:49:01 +0530
> I have a requirement to interface UART with an external microcontroller 
> using baud rate above 4Mbps, hence following is my approach to apply
> the changes. Can any one review/provide me appropriate approach.

See TCGETS2/TCSETS2 and the BOTHER flag.

The kernel supports aetting arbitary baud rates already.

Alan
