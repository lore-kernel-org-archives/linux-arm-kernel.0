From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 3 Jun 2011 09:02:47 +0400
Subject: [PATCH 1/2] clps711x/ceiva: port to use physmap flash
In-Reply-To: <1307075905.4405.130.camel@localhost>
References: <1307015648-17505-1-git-send-email-dbaryshkov@gmail.com>
	<1307075905.4405.130.camel@localhost>
Message-ID: <BANLkTi=TQfMec9Kuq4-P9Rokp44g67Tx6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/3/11, Artem Bityutskiy <Artem.Bityutskiy@nokia.com> wrote:
> On Thu, 2011-06-02 at 15:54 +0400, Dmitry Eremin-Solenikov wrote:
>> Port ceiva machine to use physmap flash instead of custom mapping driver
>> (which even can't compile cleanly with current kernels). All info
>> is gathered from drivers/mtd/maps/ceiva.c. Compile tested only.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> ---
>>  arch/arm/mach-clps711x/ceiva.c |   60
>> ++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 60 insertions(+), 0 deletions(-)
>
> Is ceiva used and not dead? May be we could kill it completely?

No functional changes to board file since start of git history. Also
I don't know how useful can be contemporary Linux on 4 MiB of RAM


-- 
With best wishes
Dmitry
