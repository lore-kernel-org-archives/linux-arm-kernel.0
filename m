From: arnd@linaro.org (Arnd Bergmann)
Date: Wed, 13 Feb 2013 09:58:01 +0000
Subject: [PATCH V2] usb: ehci: ehci-vt8500 bus glue as separate module
In-Reply-To: <1360740661-14125-1-git-send-email-manjunath.goudar@linaro.org>
References: <y> <1360740661-14125-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <201302130958.01494.arnd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 February 2013, manjunath.goudar at linaro.org wrote:
> From: Manjunath Goudar <manjunath.goudar@linaro.org>
> 
> Separate the vt8500 On-Chip host controller driver from ehci-hcd
> host code into its own static driver module

Hi Manjunath,

I see you are getting better with the patch submission procedure. I don't
know what you did different this time, but the patch actually ended
up coming out as a reply to the introductory mail this time. Whatever
you did there, please keep doing it.

There are a few things that you should improve though:

1. I did not see any replies to the review comments you got from the
other reviewers, which means either you did not reply, or you were
doing 'reply to author' rather than 'reply to all'. Please make it a
habit to reply to each reviewer, and keep the Cc list. You don't always
have to reply to each comment in one email, but when people spend time
to look at your patches and point out mistakes, they deserve to
know how you are addressing their comments.

2. For this specific patch, you sent out a single patch that is
supposed to be part of a longer series, and I expect that it would
not apply by itself. It's normally better wait until you have
received a number of comments to different patches, and then
send out the entire series again, in order to make it possible
to actually try them out. If you want to quickly send out a 
new version of a single patch out of a larger series, it's
better to reply with the new version to the old patch.

3. You really need to improve the text in the cover letter.
Remember that you cannot overcommmunicate here, and more information
about the patch can only help. In this case, the cover letter
has the exact same contents as the actual patch, which is not
helpful. Instead you could have put a text like

| This is the third version of the ehci cleanup series, which
| I based on Greg's usb-next branch from Feb 12. I addressed
| review comments from ...


	Arnd
