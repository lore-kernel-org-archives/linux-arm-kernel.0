From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Mon, 27 Oct 2014 15:13:50 +0800
Subject: [RFC V2] arm/arm64:add CONFIG_HAVE_ARCH_BITREVERSE to support
 rbit instruction
In-Reply-To: <1414392371.8884.2.camel@perches.com>
References: <35FD53F367049845BC99AC72306C23D103E010D18254@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18257@CNBJMBX05.corpusers.net>
 <1414392371.8884.2.camel@perches.com>
Message-ID: <35FD53F367049845BC99AC72306C23D103E010D18258@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> 
> If this is done, the direct uses of byte_rev_table in
> drivers/net/wireless/ath/carl9170/phy.c and sound/usb/6fire/firmware.c
> should be converted too?
> 

I think use bitrev8()  is safer than to use byte_rev_table[]  directly.
