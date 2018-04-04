From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 4 Apr 2018 20:38:23 +0200
Subject: [PATCH v7 3/4] i2c: add param sanity check to i2c_transfer()
In-Reply-To: <20180403191151.14924-4-ard.biesheuvel@linaro.org>
References: <20180403191151.14924-1-ard.biesheuvel@linaro.org>
 <20180403191151.14924-4-ard.biesheuvel@linaro.org>
Message-ID: <20180404183823.ejewg6ran5li2vt5@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 03, 2018 at 09:11:50PM +0200, Ard Biesheuvel wrote:
> The API docs describe i2c_transfer() as taking a pointer to an array
> of i2c_msg containing at least 1 entry, but leaves it to the individual
> drivers to sanity check the msgs and num parameters. Let's do this in
> core code instead.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Looks good but I want to test it myself, so I will include it in my
second pull request later.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180404/f7c1dbbc/attachment.sig>
