From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 22 Sep 2015 17:13:35 +0200
Subject: [PATCH v3 0/5] power/reset: at91: cleanups and slow clock
In-Reply-To: <1439284370-13803-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1439284370-13803-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150922151335.GA2533@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 11, 2015 at 11:12:45AM +0200, Alexandre Belloni wrote:
> As discussed this series is now removing non DT initialization, allowing to
> compile the drivers as modules and finally adding slow clock support to the
> drivers.
>
> [...]
>
>   power/reset: at91-reset: remove useless at91_reset_platform_probe()
>   power/reset: at91-reset: allow compiling as a module
>   power/reset: at91-reset: get and use slow clock
>   power/reset: at91-poweroff: allow compiling as a module
>   power/reset: at91-poweroff: get and use slow clock

Thanks, queued for 4.4. You may want to add another patch adding

MODULE_DEVICE_TABLE(of, xxx_of_match);

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150922/444bb3a7/attachment.sig>
