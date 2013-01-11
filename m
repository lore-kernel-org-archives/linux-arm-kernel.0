From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 11 Jan 2013 21:05:09 +0000
Subject: [PATCH v2 06/10] ASoC: tegra: remove auxdata
In-Reply-To: <50F07D30.9020102@wwwdotorg.org>
References: <1357891289-23500-1-git-send-email-pgaikwad@nvidia.com>
 <1357891289-23500-6-git-send-email-pgaikwad@nvidia.com>
 <50F07D30.9020102@wwwdotorg.org>
Message-ID: <20130111210509.GB8677@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 01:59:28PM -0700, Stephen Warren wrote:
> On 01/11/2013 01:01 AM, Prashant Gaikwad wrote:
> > Configlink clock information is added to device tree. Get the clocks
> > using device node. Remove AUXDATA.
> 
> Cc'ing in the ASoC maintainers as an FYI and for Acks; this patch needs
> to go through the Tegra tree due to dependencies.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130111/27c7056d/attachment.sig>
