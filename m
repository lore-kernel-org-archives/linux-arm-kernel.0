From: david.lanzendoerfer@o2s.ch (David =?ISO-8859-1?Q?Lanzend=F6rfer?=)
Date: Mon, 23 Dec 2013 11:36:29 +0100
Subject: [linux-sunxi] Re: [PATCH 1/5] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
In-Reply-To: <52AEF060.6000405@redhat.com>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
 <1743952.noztKtcF2Y@dizzy-6.site> <52AEF060.6000405@redhat.com>
Message-ID: <2155426.QS1WdjUNS8@dizzy-6.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I think that we're miss-communicating a bit here. What I'm trying to say
> is that trying to extend the dw_mmc driver to support sunxi is a bad
> idea because the sunxi hardware is quite different. And that the
> sunxi hardware having autostop allows the existing sunxi-mci driver to
> be much simpler then the dw-mmc driver.

> IOW the much simpler driver already exists and it is the sunxi-mci
> driver.
Ah! Ok. Now I get it.
Well then. I'll try to incorporate all the changes within this endless thread 
until I can get together a patchset v2 I can hand in.
Now that the lectures have ended for this semester I won't be too tired for 
straight thinking on daily basis and will be able to create such a patchset.
And please excuse my contentless answers onto the last few questions
but I really wasn't myself - so to say -  at this time (half asleep)

-david
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131223/f5d4c97a/attachment-0001.sig>
