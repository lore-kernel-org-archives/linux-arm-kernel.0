From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Feb 2012 19:54:56 +0100
Subject: Possible circular locking dependency (3.3-rc2)
In-Reply-To: <CACVXFVMfmabcH57da-prx=J950KEoFtfb-zsuBWn7VY3NaMUUQ@mail.gmail.com>
References: <20120208124147.GF16334@legolas.emea.dhcp.ti.com>
 <CACVXFVMfmabcH57da-prx=J950KEoFtfb-zsuBWn7VY3NaMUUQ@mail.gmail.com>
Message-ID: <CACRpkdZ7bs=i6Zg1ckXk-xBhY9z5VbvhVMk7p2_kP-=eB2bCKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 3:53 PM, Ming Lei <tom.leiming@gmail.com> wrote:

> Looks 'sysfs_lock' needn't to be held for unregister, so the patch below may
> fix the problem.

Looks correct to me!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
