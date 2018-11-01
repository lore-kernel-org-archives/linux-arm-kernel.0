From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 1 Nov 2018 10:56:40 +0100
Subject: [PATCH v2 0/2] pwm-tiecap: Add support for AM654 SoCs
In-Reply-To: <e3d4afac-edc3-3b2a-3c75-8eb307705dd4@ti.com>
References: <20181016060402.18756-1-vigneshr@ti.com>
 <20181016111541.GE8852@ulmo>
 <e3d4afac-edc3-3b2a-3c75-8eb307705dd4@ti.com>
Message-ID: <20181101095640.GA23707@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2018 at 07:02:23PM +0530, Vignesh R wrote:
> Hi Thierry,
> 
> On 16/10/18 4:45 PM, Thierry Reding wrote:
> > On Tue, Oct 16, 2018 at 11:34:00AM +0530, Vignesh R wrote:
> >> Couple of patches to enable pwm-tiecap driver to be used with TI's new
> >> AM654 platforms.
> >>
> >> Vignesh R (2):
> >>   dt-bindings: pwm: tiecap: Add TI AM654 SoC specific compatible
> >>   pwm: Kconfig: Enable TI ECAP driver for ARCH_K3
> >>
> >>  Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 1 +
> >>  drivers/pwm/Kconfig                                  | 5 ++---
> >>  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > Applied, thanks.
> > 
> 
> I could not see this patch series in pwm tree here:
> https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
> Is this queued for v4.20?

I forgot to push out those patches to for-next. Done that now. It's
quite late for those to go in, but since these don't touch any code
it looks okay.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181101/8625f6a5/attachment.sig>
