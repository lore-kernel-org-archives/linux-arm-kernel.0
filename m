From: broonie@kernel.org (Mark Brown)
Date: Fri, 20 Dec 2013 18:30:50 +0000
Subject: [rtc-linux] Re: Can someone Ack and queue a patch for RTC
 subsytem?
In-Reply-To: <8761qk32pj.fsf@natisbad.org>
References: <87siton6ke.fsf@natisbad.org>
 <20131219164624.GV2609@titan.lakedaemon.net>
 <20131219175738.1dad3ade@linux.lan.towertech.it>
 <8761qk32pj.fsf@natisbad.org>
Message-ID: <20131220183050.GB31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 11:17:44PM +0100, Arnaud Ebalard wrote:

> All NETGEAR ReadyNAS 102, 104 and 2120 have an ISL 12057 RTC chip which
> is used as main RTC clock but can also provide alarm. But the alarm
> interrupt line of the chip is *not* connected to the SoC. It is
> connected to some power component and can be used to wake up the NAS
> when it is completely off and the alarm rings.

Can the PMIC or whatever function as an interrupt controller and report
the interrupt on to the SoC?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/53c4ab39/attachment.sig>
