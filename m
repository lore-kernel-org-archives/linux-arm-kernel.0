From: michael.opdenacker@linaro.org (Michael Opdenacker)
Date: Fri, 04 Nov 2011 10:10:06 -0400
Subject: [PATCH 1/1] arm: omap: removed obsolete IRQF_DISABLED
In-Reply-To: <20111103221501.GD31337@atomide.com>
References: <1318139198-6865-1-git-send-email-michael.opdenacker@linaro.org>
	<1318139198-6865-2-git-send-email-michael.opdenacker@linaro.org>
	<20111103221501.GD31337@atomide.com>
Message-ID: <4EB3F23E.3060009@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 11/03/2011 06:15 PM, Tony Lindgren wrote:
> * Michael Opdenacker <michael.opdenacker@linaro.org> [111008 22:13]:
>> This flag is a NOOP since 2.6.36
> Looks like there's an ARM wide patch to do this with
> "[PATCH 03/55] arm: irq: Remove IRQF_DISABLED".
Good. Let's take this one then. I hadn't gone through all the sub
maintainers yet.

Thanks for your reply,

Cheers,

Michael.

-- 
Michael Opdenacker - Community Manager
Linaro, http://linaro.org
Phone: +33 484 253 396
IRC: 'opm' in #linaro on irc.freenode.net
