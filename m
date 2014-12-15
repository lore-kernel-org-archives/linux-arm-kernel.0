From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 15 Dec 2014 18:06:28 +0100
Subject: [linux-sunxi] Re: Linus' tree (master) not working for Allwinner
 sun4i, sun5i, sun7i SoC-s + fix
In-Reply-To: <20141215165655.GL4337@lukather>
References: <548F0C8C.3030006@gmail.com> <20141215165655.GL4337@lukather>
Message-ID: <548F1514.8090404@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 15-12-14 17:56, Maxime Ripard wrote:
> Hi,
>
> On Mon, Dec 15, 2014 at 05:30:04PM +0100, Hans de Goede wrote:
>> Hi Maxime,
>>
>> Somehow this commit of your sunxi/clocks-for-3.19 branch has made it
>> into Linus' tree:
>>
>> https://git.kernel.org/cgit/linux/kernel/git/mripard/linux.git/commit/?h=sunxi/clocks-for-3.19&id=93746e70be83a3f113134a16065957b324af50f7
>>
>> But this one has not:
>>
>> https://git.kernel.org/cgit/linux/kernel/git/mripard/linux.git/commit/?h=sunxi/clocks-for-3.19&id=acbcc0f03b15585387f9ca69c2a976b02cb69023
>>
>> Rather badly breaking Allwinner sun4i, sun5i, sun7i SoC-s.
>
> I don't know what you are looking at, but I don't see any of these
> commits in Linus' current master, either in the git repo itself, or
> using the kernel.org git interface.
>
> They're both part of Mike Turquette's clk-next though, so they should
> both land just fine whenever that will be merged.

Ah you're right, I had all patches from your sunxi/clocks-for-3.19 in my
local tree, and when rebasing on Linus' latest somehow the second one
got dropped on the rebase ?

I did not do any manual work on the rebase it went straight ahead, so
I don't understand how the patch got dropped. Anyways as you said
neither one is in Linus' tree atm, so this is not a problem, sorry
for the noise.

Regards,

Hans
