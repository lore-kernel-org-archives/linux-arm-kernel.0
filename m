From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 24 Oct 2012 17:35:02 +0200
Subject: [PATCH 0/9] ARM: Kirkwood: Convert to pinctrl
In-Reply-To: <CAMW5UfaHZE2VB5Ug-5hT_29U8zfO_qZh9T=9QBbx0xv7D+OeOA@mail.gmail.com>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <CAMW5UfaHZE2VB5Ug-5hT_29U8zfO_qZh9T=9QBbx0xv7D+OeOA@mail.gmail.com>
Message-ID: <20121024153502.GH11837@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 11:29:08AM -0400, Josh Coombs wrote:
> Andrew, are there any required kernel config changes to go along with
> this?  I didn't see any updates to the default configs in the patches
> so I want to make sure I'm testing with the right options enabled.

Hi Josh

I've been testing with is:

make kirkwood_defconfig
make 

The _defconfig file now contains all boards and should build most
common drivers to get the boards booted. If something critical is
missing for your boards, please let us known and we will add it to
_defconfig.

    Andrew
