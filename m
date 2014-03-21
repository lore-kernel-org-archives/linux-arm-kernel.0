From: broonie@kernel.org (Mark Brown)
Date: Fri, 21 Mar 2014 17:47:12 +0000
Subject: [PATCH 14/20] regulator: db8500-prcmu: Set 1.8V as a fixed
 voltage for vsmps2
In-Reply-To: <1395404057-27835-15-git-send-email-ulf.hansson@linaro.org>
References: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
 <1395404057-27835-15-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20140321174712.GD552@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 01:14:11PM +0100, Ulf Hansson wrote:
> This regulator is used for system IO and is fixed to 1.8V. Let's give
> consumers the option to fetch the voltage level.

Applied, thanks.  If the rest of the series can get applied I can
easily drop this one. 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140321/cda303ca/attachment-0001.sig>
