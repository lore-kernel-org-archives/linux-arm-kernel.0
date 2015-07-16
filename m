From: broonie@kernel.org (Mark Brown)
Date: Thu, 16 Jul 2015 22:34:29 +0100
Subject: [PATCH 4/5] regulator: 88pm800: Add 88pm860 regulator support
In-Reply-To: <1437070618-21330-5-git-send-email-vaibhav.hiremath@linaro.org>
References: <1437070618-21330-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1437070618-21330-5-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <20150716213429.GE1602@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 11:46:57PM +0530, Vaibhav Hiremath wrote:
> 88PM860 falls under 88pm800 family of devices, with
> additional feature enhancements, like,
>   - 88pm860 had additional BUCK regulator (BUCK6 and BUCK1B)
>   - Additional LDO (LDO20)
>   - different voltage and current capability

...and reverted since this doesn't build as the kbuild test robot
reported.  :(
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150716/2a0a1808/attachment.sig>
