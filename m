From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sun, 13 Nov 2011 15:37:26 +0200
Subject: [QUESTION] omap iommu: a generic IOMMU?
In-Reply-To: <CACVXFVPLgXfcpE9x2KKbU=r9_+ZeEbfo1TGndvm6yi34V15tPA@mail.gmail.com>
References: <CACVXFVPLgXfcpE9x2KKbU=r9_+ZeEbfo1TGndvm6yi34V15tPA@mail.gmail.com>
Message-ID: <CAK=Wgba+m6D7hhr0CrfzrC7mAB=6NFhbik4qte7OPGGo0v6oYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, Nov 13, 2011 at 1:04 PM, Ming Lei <tom.leiming@gmail.com> wrote:
> Just be curious, is it a generic IOMMU so that it can be used by all IO
> peripherals in OMAP4?

No, it's a dedicated iommu for the DSP and dual-M3 subsystems.

> From related source code[1] and OMAP4 TRM[2], looks like the omap iommu
> only belongs to Cortex-M3 MPU subsystem inside OMAP4 chip, so I am wondering
> why introduces the driver for arm v7 based linux kernel...

Because we control the iommus from the A9 (which is running Linux..) :)

Ohad.
