From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 May 2015 18:39:39 +0200
Subject: ARM64 kexec/kdump timeline
In-Reply-To: <55653538.8020206@codeaurora.org>
References: <555E37FC.9020800@codeaurora.org>
 <1432239334.1922.7.camel@infradead.org> <55653538.8020206@codeaurora.org>
Message-ID: <2420285.dn5MbvMKXS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 May 2015 22:08:40 Timur Tabi wrote:
> On 05/21/2015 03:15 PM, Geoff Levand wrote:
> > I feel kexec was ready to merge nine months ago.  Users have only sent
> > private e-mails like yourself, so there has been no public inquiries,
> > and so, the arm64 maintainers think kexec is not of interest to users.
> 
> Does kexec on ARM64 support ACPI?  In some of our initial tests, it 
> appears that the kexec'd kernel won't boot because it's expecting a 
> device tree, and we don't have one.

ACPI support has just been merged and is still experimental. You
should be able to boot your system by passing a DT blob at the
initial boot that matches your hardware. Can you try if that
makes kexec work?

	Arnd
