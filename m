From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 24 Sep 2018 15:26:05 +0200
Subject: [PATCH] arm64: amd: seattle: Use "spi" as name for SPI controllers
In-Reply-To: <b0721afb-ff52-f348-a481-bc4e8ee0f4a7@amd.com>
References: <20180924094648.20797-1-thierry.reding@gmail.com>
 <b0721afb-ff52-f348-a481-bc4e8ee0f4a7@amd.com>
Message-ID: <20180924132605.GB23547@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2018 at 01:09:16PM +0000, Lendacky, Thomas wrote:
> On 09/24/2018 04:46 AM, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > Recent versions of DTC contain additional checks for SPI busses and warn
> > about certain common mistakes, such as when an SPI controller has a name
> > other than "spi".
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> 
> Looks like the same patch was already submitted:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-September/601706.html

Indeed. I had done a quick search and not seen these submitted in recent
days and since the DTC change that causes these had only landed in -next
on Friday I had assumed that they must not have been fixed yet.

I wouldn't have thought that Rob had preemptively sent out the fixes.
But it being Rob, maybe I should have. =)

Sorry for the noise,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180924/1ef69125/attachment.sig>
