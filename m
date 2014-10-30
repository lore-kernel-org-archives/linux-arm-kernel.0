From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Thu, 30 Oct 2014 13:16:27 -0500
Subject: [usb] add support for APM X-Gene to xhci-platform
Message-ID: <1414692989-23128-1-git-send-email-mlangsdo@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Applied Micro's X-Gene platform uses ARM64 processors and a
standard, XHCI compatible piece of silicon for USB connectivity.
It only supports 64 bit DMA. Modify the xhci platform driver to
use either 32 bit or 64 bit DMA, as appropriate, and then
modify the platform driver to recognize the ACPI signature of
the silicon.
