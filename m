From: jcm@redhat.com (Jon Masters)
Date: Wed, 13 Jun 2012 11:06:06 -0400
Subject: [PATCH v2] arm: Add basic support for new Marvell Armada 370
 and Armada XP SoC
In-Reply-To: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
References: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <4FD8AC5E.1060804@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2012 12:52 PM, Gregory CLEMENT wrote:

> You'll find in this patch set the new version of the initial support for a
> new family of ARMv7-compatible Marvell SoCs initially submitted by my
> colleague Thomas Petazzoni. Following the conclusion of the discussion when
> we submitted our first version we have chosen to add this support for this
> SoC family in the to support in the arch/arm/mach-mvebu/ directory.

Pardon my silly question. I know that there's an effort to reconcile the
two different SoCs so you're picking a neutral name, but what does
"mvebu" mean, and will you be persistently keeping this name? Our guys
want to know what this new platform will entail for Fedora support in
terms of the platform name being used in various non-kernel places.

Jon.
