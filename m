From: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 23 Sep 2015 22:03:32 +0100
Subject: [PATCH 2/2] Convert smsc911x to use ACPI as well as DT
In-Reply-To: <560310EA.2070805@intel.com>
References: <1439417187-21411-1-git-send-email-jeremy.linton@arm.com>
 <1439417187-21411-3-git-send-email-jeremy.linton@arm.com>
 <1443033714.74600.18.camel@infradead.org> <560310EA.2070805@intel.com>
Message-ID: <1443042212.74600.30.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-09-23 at 22:51 +0200, Rafael J. Wysocki wrote:
> 
> But if the device ID is assigned already, why would it hurt to 
> actually use it?

It doesn't hurt at all, as long as we understand that there was no need
to assign it a device ID at all, at least for Linux's benefit. And as
long as it doesn't set a precedent that makes other people think they
need to do so.

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5691 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150923/39f45f7d/attachment.bin>
