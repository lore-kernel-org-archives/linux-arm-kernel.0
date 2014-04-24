From: broonie@kernel.org (Mark Brown)
Date: Thu, 24 Apr 2014 19:32:18 +0100
Subject: [PATCH 1/2] arm64, sched: Remove unused mc_capable() and
 smt_capable()
In-Reply-To: <1398217214-12204-2-git-send-email-zlim@broadcom.com>
References: <1398217214-12204-1-git-send-email-zlim@broadcom.com>
 <1398217214-12204-2-git-send-email-zlim@broadcom.com>
Message-ID: <20140424183218.GH12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 06:40:13PM -0700, Zi Shen Lim wrote:
> Remove unused and deprecated mc_capable() and smt_capable().
> 
> Both were added recently by f6e763b93a6c ("arm64: topology:
> Implement basic CPU topology support"). Uses of both were removed
> by 8e7fbcbc22c1 ("sched: Remove stale power aware scheduling
> remnants and dysfunctional knobs").

Reviewed-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140424/0bd43b2f/attachment.sig>
