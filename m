From: olof@lixom.net (Olof Johansson)
Date: Mon, 5 May 2014 13:46:33 -0700
Subject: [PATCH] ARM: multi_v7: enable AT24C EEPROM driver
In-Reply-To: <1397596227-23174-1-git-send-email-swarren@wwwdotorg.org>
References: <1397596227-23174-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140505204633.GD27961@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 03:10:27PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This is used for the board ID EEPROM on Jetson TK1, as well as likely
> a whole slew of other NVIDIA reference boards; we simply haven't added
> enabled the EEPROM in the DT files until now.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> I assume that updates to this file should go through arm-soc to minimize
> conflicts.

Applied.

-Olof
