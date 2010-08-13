From: vitalywool@gmail.com (Vitaly Wool)
Date: Fri, 13 Aug 2010 11:59:12 +0200
Subject: [RFC] new ATAG for NVS?
Message-ID: <AANLkTikMoc+QZnp2SeX2AJMCMF=FYVdWgQOri0cxTvkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

we're currently thinking over how to pass over the data from
non-volatile storage to a kernel driver. I've seen some examples in
kernel that actually read out the NV data to userspace and then supply
it as firmware to the driver that requests it. However, if NV data is
anyway processed by the bootloader, isn't it reasonable to pass it
over to kernel via ATAG? I'm eager to come up with a patch that
introduces new ATAG for that.

Thanks,
   Vitaly
