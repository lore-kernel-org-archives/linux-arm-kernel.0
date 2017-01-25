From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 25 Jan 2017 07:56:27 +0100
Subject: [RESEND PATCH 0/6] apalis-tk1: updates for v1.1 hw
In-Reply-To: <1483449646.2745.1.camel@toradex.com>
References: <20161124010456.24604-1-marcel@ziswiler.com>
 <1483449646.2745.1.camel@toradex.com>
Message-ID: <20170125065627.GA13025@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 01:20:48PM +0000, Marcel Ziswiler wrote:
> On Thu, 2016-11-24 at 02:04 +0100, marcel at ziswiler.com wrote:
> > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > 
> > 
> > This series updates the device tree for the upcoming V1.1 HW samples.
> > All changes are purely opportunistic meaning they fix stuff which on
> > older HW was anyway broken so there should be no backwards
> > compatibility issues.
> > 
> > 
> > Marcel Ziswiler (6):
> > ? apalis-tk1: remove spurious new lines
> > ? apalis-tk1: temp alert pull-up
> > ? apalis-tk1: optional displayport hot-plug detect
> > ? apalis-tk1: adjust pin muxing for v1.1 hw
> > ? apalis-tk1: working sd card detect on v1.1 hw
> > ? apalis-tk1: update compatibility comment
> > 
> > ?arch/arm/boot/dts/tegra124-apalis-eval.dts | 11 +----
> > ?arch/arm/boot/dts/tegra124-apalis.dtsi?????| 73 +++++++++++---------
> > ----------
> > ?2 files changed, 29 insertions(+), 55 deletions(-)

Applied all but the first, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/fd02828b/attachment.sig>
