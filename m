From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 26 Apr 2014 10:21:32 -0400
Subject: [PATCH v2 05/38] memory: mvebu-devbus: use ARMADA_ prefix in
 defines
In-Reply-To: <1398202002-28530-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1398202002-28530-6-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140426142132.GU28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Tue, Apr 22, 2014 at 11:26:09PM +0200, Thomas Petazzoni wrote:
> The mvebu-devbus driver currently only supports the Armada 370/XP
> family, but it can also cover the Orion5x family. However, the Orion5x
> family has a different organization of the register. Therefore, in
> preparation to the introduction of Orion5x support, we rename the
> Armada 370/XP specific definitions to have an ARMADA_ prefix.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/memory/mvebu-devbus.c | 48 +++++++++++++++++++++----------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)

Patches 5 through 9 (devbus) applied to mvebu/drivers With Sebastian's
Acks and a dep on mvebu/fixes.

thx,

Jason.
