From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 09 Oct 2015 12:18:19 -0700
Subject: [RFT 0/3] usb: usb3503: Fix probing on Arndale board (missing phy)
In-Reply-To: <1444177807-15524-1-git-send-email-k.kozlowski@samsung.com>
 (Krzysztof Kozlowski's message of "Wed, 07 Oct 2015 09:30:04 +0900")
References: <1444177807-15524-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <7hoag797gk.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzystof,

Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:

> Introduction
> ============
> This patchset tries to fix probing of usb3503 on Arndale board
> if the Samsung PHY driver is probed later (or built as a module).
>
> *The patchset was not tested on Arndale board.*
> I don't have that board. Please test it and say if the usb3503 deferred probe
> works fine and the issue is solved.

FYI... I built this series on top of  next-20151009 and using
exynos_defconfig.  I booted it on my arndale, and I still don't see the
networking come up.  Full boot log attached.

Kevin

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: boot-arndale.txt
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151009/2c313ab4/attachment-0001.txt>
