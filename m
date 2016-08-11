From: bp@alien8.de (Borislav Petkov)
Date: Thu, 11 Aug 2016 23:35:21 +0200
Subject: [PATCH 1/5] arm/defconfigs: Remove CONFIG_IPV6_PRIVACY
In-Reply-To: <4958578.R1lMSWqhcA@wuerfel>
References: <1459338168-29334-1-git-send-email-bp@alien8.de>
 <571752E8.2040103@mleia.com> <20160811170035.GD7296@nazgul.tnic>
 <4958578.R1lMSWqhcA@wuerfel>
Message-ID: <20160811213521.GD10636@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2016 at 10:26:26PM +0200, Arnd Bergmann wrote:
> I'd prefer not to do it mechanically, please check the things that
> changed to see if they made sense.

I'm hardly the guy to be in the position to verify ARM config stuff.
Actually, my original intention was much simpler:

https://lkml.kernel.org/r/1459338168-29334-2-git-send-email-bp at alien8.de

but then Vladimir suggested I should do the savedefconfig thing.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
