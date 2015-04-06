From: sre@kernel.org (Sebastian Reichel)
Date: Mon, 6 Apr 2015 19:39:27 +0200
Subject: [PATCH v4 1/6] power: twl4030-madc-battery: Convert to iio
 consumer.
In-Reply-To: <1426022847-30912-2-git-send-email-marek@goldelico.com>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
 <1426022847-30912-2-git-send-email-marek@goldelico.com>
Message-ID: <20150406173927.GE18145@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 10, 2015 at 10:27:22PM +0100, Marek Belisko wrote:
> Because of added iio error handling private data allocation was
> converted to managed to simplify code.

Thanks, pulled (only PATCH 1/6 for now).

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150406/658ae8f4/attachment.sig>
