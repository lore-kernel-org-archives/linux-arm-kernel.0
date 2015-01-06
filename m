From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 6 Jan 2015 11:03:57 +0100
Subject: [PATCH v2 12/13] ARM: dts: sun6i: Add sun6i-a31s.dtsi
In-Reply-To: <54AA59D9.7030909@redhat.com>
References: <1418836704-15689-1-git-send-email-hdegoede@redhat.com>
 <1418836704-15689-13-git-send-email-hdegoede@redhat.com>
 <20141219183450.GZ4820@lukather> <54954E77.4070302@redhat.com>
 <20141221223941.GC4820@lukather> <549820A4.9090900@redhat.com>
 <20150105090825.GA31311@lukather> <54AA59D9.7030909@redhat.com>
Message-ID: <20150106100357.GH7853@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 05, 2015 at 10:31:05AM +0100, Hans de Goede wrote:
> Thanks, while looking at your dt-for-3.20 branch I noticed that you've
> merged v2 of "ARM: dts: sun6i: Add ir node", I did a v3 adding an ir:
> label to the node, which I noticed was missing because you asked me to
> move the a31s dt stuff to moving label references, can you fix this up, or
> do you want me to do a follow up patch ?
> 
> Note that having this fixed is a pre-req for the csq-cs908 dts patch.

Ah, right. I edited your previous patch to add the label.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/82b3b061/attachment.sig>
