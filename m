From: ryan@presslab.us (Ryan Press)
Date: Fri, 29 Mar 2013 11:09:23 -0700
Subject: [PATCH] arm: mvebu: Fix the memory size on the Mirabox
In-Reply-To: <20130329180447.GK13280@titan.lakedaemon.net>
References: <1364579477-19018-1-git-send-email-ryan@presslab.us>
 <20130329180447.GK13280@titan.lakedaemon.net>
Message-ID: <CABx3TkVK86b8Ku4EvUVe8OBtprwKW6YtJ7OU6YVHa3Bd5s7DsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Fri, Mar 29, 2013 at 11:04 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Fri, Mar 29, 2013 at 10:51:17AM -0700, Ryan Press wrote:
>> The memory size in the device tree is only 512 MB, but the
>> Mirabox actually has 1 GB.
>>
>> Tested the change with memtester and no problems found.
>>
>> Signed-off-by: Ryan Press <ryan@presslab.us>
>> ---
>>  arch/arm/boot/dts/armada-370-mirabox.dts | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Thanks for the patch.  It looks good, but please don't forget to Cc: the
> maintainers (Andrew Lunn, Gregory Clemente, and myself).  I almost
> missed this one. :)
>
> thx,
>
> Jason.

Okay I didn't know I needed to do that.  Thanks!

Ryan
