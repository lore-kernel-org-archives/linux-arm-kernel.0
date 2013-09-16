From: sre@debian.org (Sebastian Reichel)
Date: Mon, 16 Sep 2013 17:01:47 +0200
Subject: [RFCv2 3/3] ARM: dts: N900: Add SSI information
In-Reply-To: <CAAwP0s0e-gYkNA78eQH7x2VJbM1byaisUeqU8YbbeWUbKwsxCQ@mail.gmail.com>
References: <1379277856-24571-1-git-send-email-sre@debian.org>
 <1379277856-24571-4-git-send-email-sre@debian.org>
 <CAAwP0s0e-gYkNA78eQH7x2VJbM1byaisUeqU8YbbeWUbKwsxCQ@mail.gmail.com>
Message-ID: <20130916150147.GA14047@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> Is the Synchronous Serial Interface (SSI)  only supported by
> OMAP34xx/OMAP35xx SoC and not by OMAP36xx/OMAP37xx SoC?
> 
> I'm asking this since if SSI is supported by both we should add the
> device nodes in omap3.dtsi instead of omap34xx.dtsi.
> 
> I thought that all OMAP3 SoC supported SSI and all OMAP4 SoC supported
> HSI but I guess I was wrong...

I just do not know. Information about the SSI core is not included
in the public OMAP TRM. It only lists the memory space as reserved.

Thus I only included it in OMAP34xx, which is used in Nokia N900 and
must support SSI.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130916/f2c6d2d9/attachment-0001.sig>
