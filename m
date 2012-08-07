From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 7 Aug 2012 14:56:41 +0000
Subject: [PATCH v3 3/7] mv643xx.c: Add basic device tree support.
In-Reply-To: <1344350092-24050-4-git-send-email-ian.molton@codethink.co.uk>
References: <1344350092-24050-1-git-send-email-ian.molton@codethink.co.uk>
 <1344350092-24050-4-git-send-email-ian.molton@codethink.co.uk>
Message-ID: <201208071456.41412.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 August 2012, Ian Molton wrote:
>     This patch adds basic device tree support to the mv643xx ethernet driver.
> 
>     It should be enough for most current users of the device, and should allow
>     a painless migration.
> 
>     Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
> ---
>  Documentation/devicetree/bindings/net/mv643xx.txt |   75 +++++++++++++++++
>  drivers/net/ethernet/marvell/mv643xx_eth.c        |   93 +++++++++++++++++++--
>  2 files changed, 161 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/mv643xx.txt

Hi Ian,

Have you had a look at Documentation/devicetree/bindings/marvell.txt ?

I think it documents some of the same thing, so it would be good
to keep all of that in one place. We might also want to move
some of the code from arch/powerpc/sysdev/mv64x60_dev.c
to live in the same place as the device driver.

	Arnd
