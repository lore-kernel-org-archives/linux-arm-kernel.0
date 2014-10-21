From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 21 Oct 2014 22:10:42 +0200
Subject: [RFC Patch 1/4] mfd: AXP20x: Add power supply bindings
 documentation
In-Reply-To: <20141020223314.0484f795@neptune.home>
References: <20141020221959.2f312906@neptune.home>
 <20141020223314.0484f795@neptune.home>
Message-ID: <20141021201042.GB7893@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 20, 2014 at 10:33:14PM +0200, Bruno Pr?mont wrote:
> 
> ---

You're missing a commit log, and your signed-off-by.

You should go through Documentation/SubmittingPatches, and make sure
to run checkpatch.pl, and fix the warning and errors.

> Note: the OCV values seem to have some defaults build into the
> PMIC though may need adjustment if the used battery has a different
> open circuit voltage curve.
> As far as understood (these values are set in vendor driver but not
> mentioned in chip documentation) they represent charge percentage
> for some predefined voltages.
> 
> If prefixing these values with "x-power," is preferred the following
> patch should becomes a dependency:
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/267606.html

Feel free to fold that patch into your serie, since it seems to have
been forgotten.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141021/3f1895f2/attachment.sig>
