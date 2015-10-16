From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 16 Oct 2015 09:46:10 +0200
Subject: [PATCH v2 0/2] pinctrl: sunxi: r_pio irq fixes
Message-ID: <1444981572-17235-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is a v2 of this patch-set which actually compiles (problem with
the second patch in v1). After testing that everything worked I extended
the irq mapping to not just cover PL5 (the pin I actually tested with)
but also all the other pins which have an irq function. I botched up
the copy paste (in some cases the irq mux is the last function so I needed
to also move a brace), and then to make things worse I also forgot to
do a compile after adding the irq muxing to the other pins.

This version has the braces moved to the proper place fixing the
compile error, otherwise it is unchanged.

Regards,

Hans
