From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Tue, 16 Nov 2010 16:28:13 +0100
Subject: [PATCH] Documentation about RS485 serial communications
In-Reply-To: <20101116143016.GB6527@ucw.cz>
References: <20100408111310.524f7354@lxorguk.ukuu.org.uk>
	<4CDBC3EC.6020707@evidence.eu.com> <20101116143016.GB6527@ucw.cz>
Message-ID: <201011161630.19107.alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday 16 November 2010, 15:30:16 Pavel Machek wrote:
> > Documentation about RS485 serial communications
> 
> I have seen hardware (kontron pmc-6l) that was capable of switching
> between RS232, RS485 and one other standard by software.

Maybe you mean RS422 here.

> Is such hw common? If so, should we have standard interface?

Especially in industrial system, you may have RS485 or RS422 additionally to 
RS232. This also often means switching some GPIO to change the external signal 
levels. Any the drivers must also be capable of turning on and off the 
transmitter.

Best regards,
Alexander
