From: broonie@kernel.org (Mark Brown)
Date: Mon, 3 Mar 2014 10:58:38 +0900
Subject: [PATCH 4/4] regulator: mc13xxx: Fix probing with DT
In-Reply-To: <1393746275-9253-4-git-send-email-shc_work@mail.ru>
References: <1393746275-9253-1-git-send-email-shc_work@mail.ru>
 <1393746275-9253-4-git-send-email-shc_work@mail.ru>
Message-ID: <20140303015838.GO2411@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 02, 2014 at 11:44:35AM +0400, Alexander Shiyan wrote:
> The nodes of regulators should be retrieved from parent device.
> Bug was be introduced by commit (regulator: mc13xxx: Fix NULL
> pointer error in non-DT mode) in conjuction with (mfd: Revert
> "mfd: Always assign of_node in mfd_add_device()").

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/1da1bfe4/attachment-0001.sig>
