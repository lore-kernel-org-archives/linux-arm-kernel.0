From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Fri, 9 Oct 2015 15:30:47 +0200
Subject: [PATCH v3] arm-soc: Add support for Sigma Designs Tango4
In-Reply-To: <5898159.aPJzsGHAv7@wuerfel>
References: <560EAA7C.3070302@free.fr> <5612A473.8030405@sigmadesigns.com>
 <5613EF4C.30603@sigmadesigns.com> <5898159.aPJzsGHAv7@wuerfel>
Message-ID: <5617C187.4010105@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2015 15:18, Arnd Bergmann wrote:

> On Tuesday 06 October 2015 17:57:00 Marc Gonzalez wrote:
>> This patch adds support for Sigma Designs "Tango4" platform, which is
>> built around the ARM Cortex A9 MPCore (single and dual core SoCs).
>>
>> Tango4 is not to be confused with Tango3, which was built around a
>> MIPS 74kf CPU.
>>
>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>> ---
>> v3 changes: Updated clock tree DT (clk driver submitted)
>>
> 
> Looks all reasonable to me now. Can I get an Ack from M?ns? It sounds
> like he is the original author of the port.

I have a v4 coming up to account for the change from "twd-never-stops"
to "always-on" requested by Mark Rutland.

I started the port by looking at Mans' Tango3 port, but the code
submitted was written by me (bugs included).

Regards.
