From: michael.williamson@criticallink.com (Michael Williamson)
Date: Tue, 04 Jan 2011 09:10:50 -0500
Subject: [PATCH 1/2] serial: Provide capability to disable modem status
	interrupts in 8250 driver
In-Reply-To: <20110104135621.56a4770e@lxorguk.ukuu.org.uk>
References: <1294149062-31173-1-git-send-email-michael.williamson@criticallink.com>
	<20110104135621.56a4770e@lxorguk.ukuu.org.uk>
Message-ID: <4D232A6A.1030307@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/4/2011 8:56 AM, Alan Cox wrote:

>> This patch was tested using a MityDSP-L138F platform having a UART CTS pin
>> connected to a clock signal (and configured, via pinmux, as a clock input
>> for another peripheral function).
> 
> Please hide such horrors in your platform code. We are trying todrive all
> the quirks stuff we can out of the core code.
> 
> Instead provide your own I/O methods when registering the port and mask
> the appropriate bogus bits in the register.
> 


Got it.  Thanks for the guidance.

-Mike
