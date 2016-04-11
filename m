From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 11 Apr 2016 09:34:08 +0200
Subject: [PATCH v5 0/2] ?hci-platform: Add support for controllers with
 more then one reset line
In-Reply-To: <1460211315-17915-1-git-send-email-hdegoede@redhat.com>
References: <1460211315-17915-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1460360048.4020.15.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, den 09.04.2016, 16:15 +0200 schrieb Hans de Goede:
> Hi Greg, et al,
> 
> Here is a resend of my last version of the patch set to support usb
> controllers which have multiple resets.
> 
> Unfortunately the shared reset controller support this depends on did
> not make it into 4.6. Philipp Zabel, the reset maintainer (in the Cc)
> has put these patches in a stable branch / tag here:
> 
> git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.7
> 
> Can you please merge in this tag and then these 2 patches for 4.7 ?

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

Note that as of now, the tag is not yet merged into the arm-soc
maintainer's for-next branch. I've sent the pull request on Mar 31 and
expect it to be merged in the next round.

regards
Philipp
