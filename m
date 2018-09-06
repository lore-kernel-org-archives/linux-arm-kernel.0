From: corbet@lwn.net (Jonathan Corbet)
Date: Thu, 6 Sep 2018 09:51:11 -0600
Subject: [PATCH] efi_stub: update documentation on dtb= parameter
In-Reply-To: <20180905190750.4566-1-grant.likely@arm.com>
References: <20180905190750.4566-1-grant.likely@arm.com>
Message-ID: <20180906095111.1a74dfcd@lwn.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  5 Sep 2018 20:07:50 +0100
Grant Likely <grant.likely@arm.com> wrote:

> The dtb= parameter is no longer the primary mechanism for providing a
> devicetree to the kernel. Now either firmware or the boot selector (ex.
> Grub) should provide the devicetree and dtb= should only be used for
> debug or when using firmware that doesn't understand DT.
> Update the EFI stub documentation to reflect the current usage.

So I hate to be obnoxious, but...

> IMPORTANT NOTICE: The contents of this email and any attachments are
> confidential and may also be privileged. If you are not the intended
> recipient, please notify the sender immediately and do not disclose the
> contents to any other person, use it for any purpose, or store or copy
> the information in any medium. Thank you.

Can I get a version of the patch without this language?  Then I'll be glad
to apply it.

Thanks,

jon
