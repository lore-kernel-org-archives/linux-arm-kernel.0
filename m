From: housel@acm.org (Peter S. Housel)
Date: Tue, 20 Oct 2015 16:40:58 -0700
Subject: [PATCH 0/2] Add EIM support for i.MX6sl
Message-ID: <1445384460-34108-1-git-send-email-housel@acm.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add missing support for the EIM block on the
i.MX6sl. With these changes, I am able to access CFI NOR flash
attached to an i.MX6SoloLite.
