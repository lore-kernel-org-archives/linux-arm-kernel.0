From: dann.frazier@canonical.com (dann frazier)
Date: Thu, 9 Nov 2017 09:16:03 -0700
Subject: [PATCH v10 0/9] LPC: legacy ISA I/O support
In-Reply-To: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
Message-ID: <CALdTtnsCXp9kone=VECSyPOi6kuYML8eU-TKHM+_ekhVoGSTYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 27, 2017 at 10:11 AM, Gabriele Paoloni
<gabriele.paoloni@huawei.com> wrote:
> From: gabriele paoloni <gabriele.paoloni@huawei.com>
>
> This patchset supports the IPMI-bt device attached to the Low-Pin-Count
> interface implemented on Hisilicon Hip06/Hip07 SoC.

fwiw, I tested this on one of our D05 boards and verified that the
IPMI SI worked fine.

Tested-by: dann frazier <dann.frazier@canonical.com>
