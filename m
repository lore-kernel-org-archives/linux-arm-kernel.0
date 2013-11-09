From: lho@apm.com (Loc Ho)
Date: Fri, 8 Nov 2013 21:32:14 -0800
Subject: [PATCH 4/5] ata: Add APM X-Gene SATA serdes functions
In-Reply-To: <20131109003821.GA22982@quad.lixom.net>
References: <1383949838-25106-1-git-send-email-lho@apm.com>
 <1383949838-25106-2-git-send-email-lho@apm.com>
 <1383949838-25106-3-git-send-email-lho@apm.com>
 <1383949838-25106-4-git-send-email-lho@apm.com>
 <1383949838-25106-5-git-send-email-lho@apm.com>
 <20131109003821.GA22982@quad.lixom.net>
Message-ID: <CAPw-ZT=Xy8XRHc+BConWz22_7+67FqVuUfoB0DtZsUCjHeb05A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Forgot to run checkpatch on this one. It will be fixed in the new version.

-Loc

On Fri, Nov 8, 2013 at 4:38 PM, Olof Johansson <olof@lixom.net> wrote:
> On Fri, Nov 08, 2013 at 03:30:37PM -0700, Loc Ho wrote:
>> Signed-off-by: Loc Ho <lho@apm.com>
>> Signed-off-by: Tuan Phan <tphan@apm.com>
>> Signed-off-by: Suman Tripathi <stripathi@apm.com>
>> ---
>>  drivers/ata/sata_xgene_serdes.c | 1982 +++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 1982 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/ata/sata_xgene_serdes.c
>
> To start with:
>
> This patch is riddled with checkpatch errors from whitespace stuff.
>
> It completely lacks any kind of patch description.
>
>
> -Olof
