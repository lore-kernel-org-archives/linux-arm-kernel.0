From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 20 Dec 2010 16:13:40 +0900
Subject: [PATCH v4 2/2] sdhci-s3c: Add support no internal clock divider
	in host controller
In-Reply-To: <20101220070601.GA22742@void.printf.net>
References: <1286776076-24970-1-git-send-email-kgene.kim@samsung.com>
	<AANLkTinJE0GOFbVEWNdTxwpv2Dwi6im0ipkPsf8jEhU1@mail.gmail.com>
	<20101220070601.GA22742@void.printf.net>
Message-ID: <AANLkTi=RTT=YjJ4t+BtFikOE_M8TWMNjCHw6z=S3ObcK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 20, 2010 at 4:06 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi Kyungmin, Ben,
>
> On Mon, Dec 20, 2010 at 11:08:00AM +0900, Kyungmin Park wrote:
>> Hi Chris,
>>
>> Unfortunately it's not merged your tree.
>> It's required for s5pc210 board. can you merge it for 37-rc6 or later?
>
> I'm not comfortable slipping this into .37 (-rc6 has already been
> released) without an ACK from Ben, but I will accept it into mmc-next
> for the .38 merge window, and Ben can yell sometime before the merge
> if he doesn't agree. ?Does that work okay for you?

It's actually bug fix for s5pc210. If there are another rc please
include it if possible. But it's okay to merge .38.

Thank you,
Kyungmin Park
