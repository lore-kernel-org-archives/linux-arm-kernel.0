From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 5 Nov 2009 08:40:00 +0100
Subject: [PATCH 0/6] mx31moboard: patches for next merge window v2
In-Reply-To: <1257268191-19075-1-git-send-email-valentin.longchamp@epfl.ch>
References: <1257268191-19075-1-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <20091105074000.GF14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2009 at 06:09:45PM +0100, Valentin Longchamp wrote:
> The main peripheral that we are using and that still is missing is the USB
> host, but since the driver still needs a few improvements, I keep it aside
> for now.

It has been added to Greg's usb-linux tree now. And I posted some more
versions of the ulpi viewport support to Sascha and the linux-usb ML
(unfortunately, someone culled the arm-linux ML from Cc which I realized
way too late).

So, if Sascha applied the ulpi patch, all pieces should be on their way
to mainline now. Finally :)

Daniel
