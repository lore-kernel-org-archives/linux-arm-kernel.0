From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 16 Apr 2014 18:34:47 +0200
Subject: [PATCH 5/6] ARM: mvebu: Add thermal quirk for the Armada 375 DB
 board
In-Reply-To: <20140416181938.6e8f8f4b@skate>
References: <1397657720-10893-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1397657720-10893-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <534EA8C9.7010907@gmail.com> <20140416180315.5153c3f7@skate>
 <20140416160824.GA14842@lunn.ch> <20140416181938.6e8f8f4b@skate>
Message-ID: <20140416163447.GB14842@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> So, I would like to see the Z1 stepping supported for now, and have the
> freedom to remove its support later once we are all ready to switch to
> A0.

Hi Thomas

Sounds like a good plan. Try to keep all the mess to support Z1 in one
place so that it can be easily taken out once people have A0.

       Andrew
