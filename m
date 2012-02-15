From: jarkko.nikula@bitmer.com (Jarkko Nikula)
Date: Wed, 15 Feb 2012 21:06:00 +0200
Subject: [RFC 00/11]O MAP/ASoC: Move and merge McBSP driver under ASoC
In-Reply-To: <CAPo=G1z6H+ZXd-cmYSpKXC-XNci7=iUz2he62ze9MyErkmUfOA@mail.gmail.com>
References: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com>
 <CAPo=G1z6H+ZXd-cmYSpKXC-XNci7=iUz2he62ze9MyErkmUfOA@mail.gmail.com>
Message-ID: <4F3C0218.6060802@bitmer.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/15/2012 05:56 PM, Ujfalusi, Peter wrote:
> Hi,
> 
> CC-ing Janusz, since he is the only one I know who have, and use OMAP1
> with audio...
> Janusz: if your time allows would you be able to test this series on
> OMAP1 (it compiles...)?
> 
Yeah, it would be shame to break omap1, especially considering how much
Janusz has put his personal effort on it.

>> McBSP is only used by audio, there are no known other users of the OMAP McBSP
>> (well, Nokia n700 has the WLAN connected through McBSP but we do not have
>> driver for that anyway).
>>
And since the clock stop mode is not supported in newer omaps there very
unlikely won't be.

>> The series was created against Takashi's topic/asoc branch. I have tested it on
>> Beagle xM, and compile tested it for OMAP1, OMAP2, and OMAP4 as well.
>>
>> I'm going to do more work on the cleanup, and the plan is to merge the two files
>> into one (mcbsp.c -> omap-mcbsp.c) eventually.
>>
>> Comments, testers are welcome...

Unfortunately I won't be able to give any test this week but at quick
look the set looks good to me.

-- 
Jarkko
