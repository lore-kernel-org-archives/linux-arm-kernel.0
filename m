From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 3 Mar 2016 13:37:17 +0100
Subject: [PATCH 12/17] arm: Add new mach-oxnas
In-Reply-To: <20160303114932.GV19428@n2100.arm.linux.org.uk>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457005210-18485-13-git-send-email-narmstrong@baylibre.com>
 <20160303114932.GV19428@n2100.arm.linux.org.uk>
Message-ID: <56D82FFD.9010009@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2016 12:49 PM, Russell King - ARM Linux wrote:
> Looking at the current contents of oxnas.c, do you actually need it?
> What happens if you boot your with your DT without this file being
> built?
> 

No, it's useless for now, it boots perfectly without.
It was only a base for adding the reset management in a next patchset.

Neil
