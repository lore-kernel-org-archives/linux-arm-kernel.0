From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Sep 2014 12:54:46 +0100
Subject: [PATCH v4 0/9] PM / Domains: Generic OF-based support
In-Reply-To: <1410262570-22785-1-git-send-email-ulf.hansson@linaro.org>
References: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org>
 <1410262570-22785-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20140909115446.GW2601@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 01:36:01PM +0200, Ulf Hansson wrote:
> Changes in v4:
> 	- Rebased patch "PM / Domains: Add generic OF-based PM domain look-up" -
> 	  and updated the author and the commit message.
> 	- Adopted review comments for "PM / Domains: Add APIs to attach/detach
> 	  a PM domain for a device".
> 	- Updated author and commit message for "ARM: exynos: Move to generic
> 	  PM domain DT bindings".
> 	- Added some acks and reviewed by tags.
> 	- Started to use the "--in-reply-to" option to git-send-email. It should
> 	  provide the option to show a better diffstat per patch.

Please don't send serieses in reply to earlier versions, it buries
things in the middle of old discussions which can mean they don't get
noticed, especially when you're sending multiple large patch serieses at
the same time.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140909/9406e4fc/attachment.sig>
