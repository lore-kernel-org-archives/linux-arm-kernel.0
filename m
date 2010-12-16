From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Dec 2010 14:34:05 +0100
Subject: [PATCH 0/9] TI DMM-TILER driver
In-Reply-To: <1291674446-10766-1-git-send-email-davidsin@ti.com>
References: <1291674446-10766-1-git-send-email-davidsin@ti.com>
Message-ID: <201012161434.05768.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 December 2010, David Sin wrote:
> Tiling and Isometric Lightweight Engine for Rotation (TILER) driver
> =====
> 
> Dynamic Memory Manager (DMM) is a hardware block made by Texas Instruments.
> Within the DMM exists at least one TILER hardware component.  Its purpose is to
> organize video/image memory in a 2-dimensional fashion to limit memory
> bandwidth and facilitate 0 effort rotation and mirroring.  The TILER driver
> facilitates allocating, freeing, as well as mapping 2D blocks (areas) in the
> TILER container(s).  It also facilitates rotating and mirroring the allocated
> blocks or its rectangular subsections.

How does this relate to DRM/GEM? I don't understand too much about graphics
drivers, but it does sound like there is some overlap in functionality.

I guess at the very least the DMM should live in drivers/gpu/ instead of
drivers/misc, but perhaps it could be integrated more closely with the
existing code there.

	Arnd
