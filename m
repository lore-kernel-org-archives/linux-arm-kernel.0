From: broonie@kernel.org (Mark Brown)
Date: Thu, 5 Sep 2013 18:18:13 +0100
Subject: [PATCH] ASoC: kirkwood: change the compatible string of the
 kirkwood-i2s driver
In-Reply-To: <20130905190341.4a4a7820@skate>
References: <1378385791-29551-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130905185456.175f556b@armhf> <20130905190341.4a4a7820@skate>
Message-ID: <20130905171813.GA2839@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 05, 2013 at 07:03:41PM +0200, Thomas Petazzoni wrote:

> not exactly the same. Should this error interrupt become useful in the
> driver, it should be done only for Dove, so it makes sense to have two
> different compatible strings.

In general it's reasonable to add compatible strings for the SoCs anyway
since even if we don't know of any reason why we'd want to distingush
between them right now it's possible that in the future some reason
might be discovered (such as an erratum being found).  Worst case the
kernel just treats both compatible strings identically which isn't a
great loss.  It's not essential though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130905/4ad8ba68/attachment-0001.sig>
