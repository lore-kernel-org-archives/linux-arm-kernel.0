From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 9 May 2011 14:46:10 +0100
Subject: [PATCH v4 08/11] tty: add pruss SUART driver
In-Reply-To: <034A6447E0D54737B5CEE009A4D20B37@subhasishg>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<1303474109-6212-9-git-send-email-subhasish@mistralsolutions.com>
	<034A6447E0D54737B5CEE009A4D20B37@subhasishg>
Message-ID: <20110509144610.6b4f7090@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I then modified this function to as follows and the error is not observed 
> anymore.

That looks like you are somehow calling uart_carrier_raised somewhere
with interrupts disabled ?

Alan
