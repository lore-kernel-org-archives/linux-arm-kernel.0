From: girish.shivananjappa@linaro.org (Girish K S)
Date: Thu, 15 Sep 2011 17:28:05 +0530
Subject: confusion regarding the CMD19 and CMD21 in eMMC/SD card spec
Message-ID: <CAGxe1ZH=mrAdfVR7Uw8mYNAD43BAbW7VGuhA1pN9hbSjTG9HVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all,
             The eMMC 4.5 specification mentions that the CMD21 in
class 2 is a SEND_TUNING BLOCK command. where as the SD card
specification
in the given link says CMD19 in class 2 is the SEND_TUNING_BLOCK
http://www.scribd.com/doc/50685191/53/Figure-4-8-Send-Tuning-Block-Command.
Also the implementation in the drivers/mmc/host/sdhci.c uses the CMD19
as the SEND_TUNING_BLOCK.
Can anybody clarify why there is overlapping in this command number.
May be my understand is wrong.

In the MMC spec the CMD19 is BUS_TEST_W in class 0 and CMD21 is
reserved till eMMC 4.41 version.
But in the SD specification (given link) CMD19 is SEND_TUNING_BLOCK
and CMD21 is reserved.

Thanks and regards
Girish K S
