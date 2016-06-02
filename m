From: eric@anholt.net (Eric Anholt)
Date: Thu, 02 Jun 2016 11:18:52 -0700
Subject: [PATCH 32/32] mmc: bcm2835: Import bcm2835-mmc and switch to it
In-Reply-To: <e16936ee-3b0d-3798-72e0-8969c2c1a309@i2se.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <1464817421-8519-33-git-send-email-kraxel@redhat.com>
 <e16936ee-3b0d-3798-72e0-8969c2c1a309@i2se.com>
Message-ID: <87oa7j314j.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Gerd,
>
> Am 01.06.2016 um 23:43 schrieb Gerd Hoffmann:
>> From: Eric Anholt <eric@anholt.net>
>>
>> With this we can get wifi (brcmfmac) to probe.  Without it we're stuck
>> with timeouts from sdio.c when it tries to set the bus width to 4.
>
> adding a new MMC driver to fix a wifi issue is really weird.
>
> Beside that there are already two MMC drivers (sdhci-bcm2835.c and
> sdhci-iproc.c) in the Kernel which are compatible to BCM2835. Why should
> we add two new ones?

Despite the fact that this is my commit, I don't think it should be
merged.  We should figure out why sdhci-iproc.c isn't working, instead.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160602/2d337722/attachment.sig>
