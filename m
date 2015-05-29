From: lho@apm.com (Loc Ho)
Date: Fri, 29 May 2015 11:06:35 -0700
Subject: [PATCH v11 0/4] edac: Add APM X-Gene SoC EDAC driver
In-Reply-To: <20150529094654.GD31435@pd.tnic>
References: <1432337580-3750-1-git-send-email-lho@apm.com>
 <20150529094654.GD31435@pd.tnic>
Message-ID: <CAPw-ZTnLqx0KsQkmv++zQRQ7hroaKML1rWgVafisENam0J17Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 29, 2015 at 2:46 AM, Borislav Petkov <bp@alien8.de> wrote:
> On Fri, May 22, 2015 at 05:32:55PM -0600, Loc Ho wrote:
>> This patch adds support for the APM X-Gene SoC EDAC driver for DT.
>
> Applied, thanks!
>
> Phew, that was a looong process. But the final result looks nice. So
> thanks for the perseverance.
>
> All is here, if you want to do testing and other fun before the merge
> window opens:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git#for-next
>

I pull this and got this error:

/projects/svdc/P4sbSW/lho/xgene2/processor/git.lho/edac-next/drivers/edac/edac_stub.c:19:22:
fatal error: asm/edac.h: No such file or directory
 #include <asm/edac.h>
                      ^
compilation terminated.

-Loc
