From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 May 2016 22:12:23 +0200
Subject: [PATCH V4 0/2] vfio, platform: add ACPI support
In-Reply-To: <1462136872-17590-1-git-send-email-okaya@codeaurora.org>
References: <1462136872-17590-1-git-send-email-okaya@codeaurora.org>
Message-ID: <3322250.xDEDujoeAM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 01 May 2016 17:07:50 Sinan Kaya wrote:
> The patchset makes three different changes.
> 1. Add support for probing ACPI platform devices.
> 2. Add support for ACPI _RST method support during reset
> 3. Make reset driver a requirement by default with an optional
>    kernel command line override

Looks nice, thanks for rewriting this!

For future submissions, it would help to have a list of changes
compared to the previous versions a the patch set in the cover
letter to help reviewers, but this time my memory was still fresh
enough.

	Arnd
