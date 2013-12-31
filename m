From: broonie@kernel.org (Mark Brown)
Date: Tue, 31 Dec 2013 13:06:29 +0000
Subject: [PATCH v2] regulator: act8865: register all regulators
 regardless of how many are used
In-Reply-To: <1388453272-5287-1-git-send-email-wenyou.yang@atmel.com>
References: <1388453272-5287-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20131231130629.GY31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 31, 2013 at 09:27:52AM +0800, Wenyou Yang wrote:
> v2 changlog:
>  1./ Rebased on the latest code of for-next branch.

Applied, but if you are including a changelog in your patch please
include it after the --- so it doesn't clutter up the git history.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131231/c71334e5/attachment.sig>
