From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 27 Mar 2015 17:36:32 +0000
Subject: [Linux-kernel] [RFC] add avr32/at91 on-chip iO accessors
In-Reply-To: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <55159520.9080409@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/03/15 11:45, Ben Dooks wrote:
> As discussed from Ben Hutchings' suggestion on the original series,
> avoid open coding the AVR32/AT91 IO accessors.

I think the only thing to discuss is whether to use linux/atmel_io.h
or maybe put it under include/soc/atmel ?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
