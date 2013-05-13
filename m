From: jp.francois@cynove.com (jean-philippe francois)
Date: Mon, 13 May 2013 11:44:04 +0200
Subject: Board file to device tree migration
Message-ID: <CAGGh5h3MC=ruocV9u6Cig=oiTtqU8GtpQ6sRKUZmUNk-C7Houw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am maintaining a board file, which i did not submit since the board
was developped after the decision was taken to move to device tree,
and I figured no more board file would be accepted.

I can't move to full device tree, since if my understanding is
correct, the omap3-isp is not supported yet, and our board is a
camera, so isp is mandatory.

My question is, is it possible to do a mixed style init, with some of
the devices coming from a board file, and others from a dts file ? Is
there any example of board using this kind of mixed init ?

Regards,
Jean-Philippe Fran?ois
