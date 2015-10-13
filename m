From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 13 Oct 2015 14:37:44 +0200
Subject: [PATCH resend 0/1] ARM: dts: sun6i: Turn on gmac on Colombus
Message-ID: <1444739865-26497-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

This is a resend of a patch from a while ago. Back then there was some
discussion on the interaction of this patch with various regulators.

In the mean time I've tried to turn of the regulator in question, and
I can confirm that the gmac keeps working just fine then, so there
is no missing dependency on a regulator and this patch can go in as as.

Regards,

Hans
