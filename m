From: holler@ahsoftware.de (Alexander Holler)
Date: Wed, 14 May 2014 17:02:24 +0200
Subject: [RFC PATCH 0/9] dt: dependencies (for deterministic driver
 initialization order based on the DT)
In-Reply-To: <20140514141914.446F7C4153D@trevor.secretlab.ca>
References: <1399913280-6915-1-git-send-email-holler@ahsoftware.de>
 <20140514141914.446F7C4153D@trevor.secretlab.ca>
Message-ID: <53738580.7000902@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 14.05.2014 16:19, schrieb Grant Likely:

> Rather than a dtb schema change, for the most common properties (irqs,
> clocks, gpios), we could extract dependencies at boot time. I don't like
> the idea of adding a separate depends-on property because it is very
> easy to get it out of sync with the actual binding data (dtc is not the
> only tool that manipulates .dtbs. Firmware will fiddle with it too).

Then that stuff has to fiddle correct. Sorry, but trying to solve all 
problems right from the beginning just leads to endless talks with no 
end and nothing will happen at all because nobody aggrees how to start.

Regards,

Alexander Holler
