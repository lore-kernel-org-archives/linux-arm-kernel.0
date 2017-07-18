From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jul 2017 16:28:10 +0200
Subject: [PATCH v2 6/8] staging: fsl-mc: don't use raw device io functions
In-Reply-To: <596E1A77.4030204@nxp.com>
References: <20170718133723.12709-1-laurentiu.tudor@nxp.com>
 <20170718133723.12709-7-laurentiu.tudor@nxp.com>
 <CAK8P3a0zH1nVoppNkT=uVgFp-NUkmenZ0AVc9vOwHEe_VEt_cQ@mail.gmail.com>
 <596E1A77.4030204@nxp.com>
Message-ID: <CAK8P3a3hxA0Vi=BSuuhROQN7gieyyLeSRoRovjH4Vb9mQCAzuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 4:26 PM, Laurentiu Tudor
<laurentiu.tudor@nxp.com> wrote:
>
> Maybe i made an error in my previous emails, but the hi-lo variant is
> the correct one. The command execution is triggered when the _first_
> 32-bit half of the header (header&0xffffffff) is written, so that's why
> it must be written last.

I'm pretty sure I just misremembered it then. Thanks for the clarification.

        Arnd
