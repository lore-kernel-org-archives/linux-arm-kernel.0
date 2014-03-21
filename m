From: broonie@kernel.org (Mark Brown)
Date: Fri, 21 Mar 2014 12:25:45 +0000
Subject: [PATCH 14/20] regulator: db8500-prcmu: Set 1.8V as a fixed
 voltage for vsmps2
In-Reply-To: <1395404057-27835-15-git-send-email-ulf.hansson@linaro.org>
References: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
 <1395404057-27835-15-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20140321122545.GP11706@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 01:14:11PM +0100, Ulf Hansson wrote:

> Then intent is to merge this complete patchset all together to not break
> anything. Thus I only request for an ack for this particular patch.

TBH given that we're at -rc7 and you're unlikely to get the rest of
whatever this is merged before the merge window it's as easy for me to
just apply it.  Make sense?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140321/7f798cb9/attachment.sig>
