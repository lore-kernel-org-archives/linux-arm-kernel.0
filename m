From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 30 Jun 2014 21:51:09 +0200
Subject: [RFC 3/4] soc/tegra: Initialize interrupt controller from DT
In-Reply-To: <20140630113013.GS3679@tbergstrom-lnx.Nvidia.com>
References: <1403888329-24755-1-git-send-email-thierry.reding@gmail.com>
 <1403888329-24755-3-git-send-email-thierry.reding@gmail.com>
 <20140630113013.GS3679@tbergstrom-lnx.Nvidia.com>
Message-ID: <20140630195108.GA1351@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 02:30:13PM +0300, Peter De Schrijver wrote:
> On Fri, Jun 27, 2014 at 06:58:48PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > Obtains the register ranges for the legacy interrupt controller from DT
> > and provide hard-coded values as fallback.
> > 
> 
> Any reason this file cannot be in drivers/irqchip/ ?

I seem to remember that I tried that at one point and it didn't work,
but I can't recall the exact reason. I'll give it another try.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140630/4e814634/attachment.sig>
