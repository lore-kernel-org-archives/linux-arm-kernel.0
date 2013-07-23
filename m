From: olof@lixom.net (Olof Johansson)
Date: Mon, 22 Jul 2013 20:04:19 -0700
Subject: [PATCH] ARM: highbank: Only touch common coherency control
 register fields
In-Reply-To: <1374436417-29761-1-git-send-email-robherring2@gmail.com>
References: <1374436417-29761-1-git-send-email-robherring2@gmail.com>
Message-ID: <20130723030419.GD16733@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 21, 2013 at 02:53:37PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Midway adds new register fields to the coherency control registers, so
> writing absolute values will break on Midway. Change the register
> accesses to only modify the necessary and common fields in order to
> support both Midway and Highbank.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Applied to fixes, thanks.


-Olof
