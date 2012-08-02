From: zonque@gmail.com (Daniel Mack)
Date: Fri, 03 Aug 2012 00:58:34 +0200
Subject: am33xx: default to status = "disabled"?
Message-ID: <501B061A.6080008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

currently, all devices in arch/arm/boot/dts/am33xx.dtsi are enabled by
default. However, depending on the actual board dts, only some of the
devices should actually be initialized, given that they only make sense
if their pins are actually wired on the board.

On other platform, such devices are marked with status = "disabled", and
the board files re-enable those they really use by overriding that
status again. That approach seems to make sense - shouldn't the same be
done in am33xx.dtsi or am I missing something?


Daniel
