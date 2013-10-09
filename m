From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 09 Oct 2013 13:57:29 -0700
Subject: [GIT PULL]socfpga: DTS updates for v3.13
In-Reply-To: <1381198434-9583-1-git-send-email-dinguyen@altera.com>
 (dinguyen@altera.com's message of "Mon, 7 Oct 2013 21:13:54 -0500")
References: <1381198434-9583-1-git-send-email-dinguyen@altera.com>
Message-ID: <87y562rwli.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<dinguyen@altera.com> writes:

> Hi Kevin, Olof, and Arnd:
>
> Please consider these DTS updates for the Altera SOCFPGA platform for v3.13:
>
> Five of the six patches do NOT have an Ack from the DTS maintainers. I have
> sent the patches out for review, but since these patches do not change
> bindings nor add new ones, I don't think they will get too much attention.
>
> Please advise if you think I need to wait for Ack(s) from them.

The DT maintainers are primarily there to review new/modified bindings,
so if there are now new/modified bindings, it's not a hard requirement
for them to review/ack (though we still prefer it.)

In this case, it's mostly just reorganizing and cleanup of existing dts
data, so there are no problems with us taking it.

That being said, the patch content looks fine, but as a matter of
process, since you took accepted/queued these patches from Steffen into
your tree before passing them on to us, you should have a Signed-off-by:
on them instead of an Acked-by: since you're formally on the delivery
path. (c.f. sections 12 & 13 of Documentation/SubmittingPatches for all
the details.)

Could you please respin a branch with the proper signoffs, and then I'll
queue it up for v3.13.

Thanks,

Kevin
