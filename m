From: broonie@kernel.org (Mark Brown)
Date: Fri, 25 Sep 2015 11:01:39 -0700
Subject: [Patch v3 00/10] Add RPM/SMD Support for QCOM platforms
In-Reply-To: <1443122339-13917-1-git-send-email-agross@codeaurora.org>
References: <1443122339-13917-1-git-send-email-agross@codeaurora.org>
Message-ID: <20150925180139.GM30445@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2015 at 02:18:49PM -0500, Andy Gross wrote:
> This patch set cleans up the documentation that is currently in place for the
> SMD, SMD-RPM, and SMD-RPM regulators.  In addition, this patch set adds support
> for the PM8916 found on MSM8916 platforms and the PMA8084 found on APQ8084
> platforms.

The regulator patches are fine but depend on the first patch moving the
documentation around - I don't know how you want to handle this?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150925/a60da526/attachment.sig>
