From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 23 Sep 2015 17:37:48 +0100
Subject: [PATCH v2 1/3] Docs: dt: Add PCI MSI map bindings
In-Reply-To: <1442966406-13198-2-git-send-email-ddaney.cavm@gmail.com>
References: <1442966406-13198-1-git-send-email-ddaney.cavm@gmail.com>
 <1442966406-13198-2-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20150923173748.0c684c6a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Sep 2015 17:00:04 -0700
David Daney <ddaney.cavm@gmail.com> wrote:

> From: Mark Rutland <mark.rutland@arm.com>
> 
> Currently msi-parent is used by a few bindings to describe the
> relationship between a PCI root complex and a single MSI controller, but
> this property does not have a generic binding document.
> 
> Additionally, msi-parent is insufficient to describe more complex
> relationships between MSI controllers and devices under a root complex,
> where devices may be able to target multiple MSI controllers, or where
> MSI controllers use (non-probeable) sideband information to distinguish
> devices.
> 
> This patch adds a generic binding for mapping PCI devices to MSI
> controllers. This document covers msi-parent, and a new msi-map property
> (specific to PCI*) which may be used to map devices (identified by their
> Requester ID) to sideband data for each MSI controller that they may
> target.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: David Daney <david.daney@cavium.com>

I thought I had done it already, but nevertheless:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
