From: olof@lixom.net (Olof Johansson)
Date: Wed, 19 Apr 2017 06:48:40 -0700
Subject: [GIT PULL 1/2] omap devicetree changes for v4.12, part 2
In-Reply-To: <58ebe106.066f630a.acb55.1f9aSMTPIN_ADDED_BROKEN@mx.google.com>
References: <58ebe106.066f630a.acb55.1f9aSMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <20170419134840.GC29219@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 10, 2017 at 12:46:06PM -0700, Tony Lindgren wrote:
> The following changes since commit da72e4936445e1081e1223fc58470644da8e8cdb:
> 
>   Merge branch 'omap-for-v4.12/dt-droid4-v2' into omap-for-v4.12/dt-v2 (2017-03-28 14:00:55 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.12/dt-pt2-signed
> 
> for you to fetch changes up to b4e1566e4c5e9fcaf9e17ad741b6094b4f3ddce5:
> 
>   Merge branch 'omap-for-v4.12/dt-droid4-v2' into omap-for-v4.12/dt-v2 (2017-04-09 16:35:51 -0700)
> 
> ----------------------------------------------------------------
> Second set of devicetree changes for omaps for v4.12 merge window
> to configure various devices:
> 
> - Enable DCAN on am57xx-idk
> 
> - Enable CPSW ethernet0 and 1 on am335x-icev2
> 
> - Non-critical fix for droid 4 PMIC interrupt triggering
> 
> - Stop disabling SRAM and GPMC on droid 4
> 
> - Configure CPCAP PMIC related devices on droid 4 for ADC, charger
>   and USB PHY. The charger and USB PHY drivers are still being
>   discussed, but the binding for them has been acked by Rob and
>   Sebastian so they should be safe to merge together with the ADC
>   driver in Linux next that they depend on

Merged, thanks.


-Olof
