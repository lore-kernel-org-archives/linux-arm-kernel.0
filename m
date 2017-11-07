From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 7 Nov 2017 12:01:15 +0100
Subject: [PATCH 1/1] add rgb888 pins to a20 to enable parallel rgb LCD
In-Reply-To: <1510050759-6110-1-git-send-email-giulio.benetti@micronovasrl.com>
References: <1510050759-6110-1-git-send-email-giulio.benetti@micronovasrl.com>
Message-ID: <20171107110115.dkzzcaiokhocc2qu@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 07, 2017 at 11:32:39AM +0100, Giulio Benetti wrote:
> This patch gives possibility to set parallel lcd pins for RGB888.
> To be used with tcon0 in your <target>.dts
> 
> Best regards
> Giulio Benetti
> Micronova srl

This isn't a cover letter, but a commit log. You should document why
and how you did that change, nothing else.

On what board is this supposed to be used?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171107/ca02cc10/attachment.sig>
