From: eric.miao@linaro.org (Eric Miao)
Date: Thu, 17 Nov 2011 21:02:13 +0800
Subject: [PATCH 1/1] ARM: imx6q: move clock register map to
 machine_desc.map_io
In-Reply-To: <20111117122826.GJ14656@S2100-06.ap.freescale.net>
References: <1321527269-26784-1-git-send-email-richard.zhao@linaro.org>
 <CAMPhdO89_hpk287CF3oYeaQK02RZ0ouOB_Bt2egDuJc3HA7s1g@mail.gmail.com>
 <20111117122826.GJ14656@S2100-06.ap.freescale.net>
Message-ID: <CAMPhdO8yEpu6KeEGS2gz4gcX+E6Vm2VRZ3GcODQ-_4GoSXU_pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> I don't think we need to export this function.
>
> Instead of putting the extern declaration in mach-imx6q.c which will
> introduce a checkpatch warning, it's good to have it in the header.
>

OK, I see the point here - having map_io() to call back into
clock-imx6q.c.
