From: jorgeluis.zapata@gmail.com (Jorge Luis Zapata Muga)
Date: Wed, 21 Mar 2012 18:40:24 +0100
Subject: AMP IPC
Message-ID: <CANThrT_wahTpwRDcx-DGQWpDW7j0psKZsk92-4_+vy_Y=xyvtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I have to add support for an ARM based board and develop an IPC
mechanism for its multiple AMP cores it has, looking on the current
state of things, seems that there are several attempts for this,
basically:

- remoteporc/rpmsg based in virtio
- peripheral image loader (PIL)
- PRUSS (Programmable Real-time Unit Sub System)
- maybe others I'm missing?

Could someone explain what has been adopted? is there some common
effort for this need? is there some branch where the patches have been
accepted?

Best Regards
