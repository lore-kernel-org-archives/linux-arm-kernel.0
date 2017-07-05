From: zhang.lyra@gmail.com (Chunyan Zhang)
Date: Wed, 5 Jul 2017 18:18:56 +0800
Subject: [PATCH 2/2] misc: added Spreadtrum's radio driver
In-Reply-To: <CAK8P3a0i-H=uU=9DNJbtK2EMX2GJ5cL_TW0roSHpa6tHTcZ2sg@mail.gmail.com>
References: <20170704101508.30946-1-chunyan.zhang@spreadtrum.com>
 <20170704101508.30946-3-chunyan.zhang@spreadtrum.com>
 <CAK8P3a0i-H=uU=9DNJbtK2EMX2GJ5cL_TW0roSHpa6tHTcZ2sg@mail.gmail.com>
Message-ID: <CAAfSe-vj76psYw2uzC2w0pASRT-FGHqXph0zWE_3tmMVzMHKvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 July 2017 at 18:51, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Jul 4, 2017 at 12:15 PM, Chunyan Zhang
> <chunyan.zhang@spreadtrum.com> wrote:
>> This patch added FM radio driver for Spreadtrum's SC2342, which's
>> a WCN SoC, also added a new directory for Spreadtrum's WCN SoCs.
>>
>> Signed-off-by: Songhe Wei <songhe.wei@spreadtrum.com>
>> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
>
> (adding linux-media folks to Cc)

(You forgot to add them in :))

>
> Hi Chunyan,

Hi Arnd,

>
> Thanks for posting this for inclusion as Greg asked for. I'm not sure what
> the policy is for new radio drivers, but I assume this would have to go
> to drivers/staging/media/ as it is a driver for hardware that fits into
> drivers/media/radio but doesn't use the respective APIs.

Ok, I agree to let it go to drivers/staging/media/.

Like I mentioned, SC2342 includes many functions, this patch is only
adding FM radio function included in SC2342 to the kernel tree.  So I
figure that its lifetime probably will not be too long, will remove it
from the kernel tree when we have a clean enough version of the whole
SC2342 drivers for the official upstreaming.

Thanks,
Chunyan

>
>         Arnd
> ---
> end of message, full patch quoted for reference below
>
