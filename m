From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 25 Jan 2011 21:16:24 -0700
Subject: [PATCH v2 28/28] ARM: tegra: clock: Add forward reference to
	struct clk
In-Reply-To: <AANLkTi=3P5VWv2PA3R9=UZtwBkUxauhVGyCAzp_XNTBp@mail.gmail.com>
References: <1295834493-5019-1-git-send-email-ccross@android.com>
	<1295834493-5019-29-git-send-email-ccross@android.com>
	<AANLkTimKqkKFuKCKPV2jSjUtPqo4tbonwR1iO2rsrK1r@mail.gmail.com>
	<AANLkTi=3P5VWv2PA3R9=UZtwBkUxauhVGyCAzp_XNTBp@mail.gmail.com>
Message-ID: <AANLkTimxUyk7NSoKXb0CeQq9it2vnZ4T4mecQyUXC2gG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25, 2011 at 8:21 PM, Colin Cross <ccross@android.com> wrote:
> On Tue, Jan 25, 2011 at 7:19 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On Sun, Jan 23, 2011 at 7:01 PM, Colin Cross <ccross@android.com> wrote:
>>> Signed-off-by: Colin Cross <ccross@android.com>
>>
>> Hi Colin,
>>
>> This build warning exists in current mainline. ?It should go out to
>> Linus now instead of waiting for 2.6.29.
>>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>>
>> g.
>
> It will, I just haven't sent it yet. ?I have one more patch I'd like
> to send with it to prevent a possible variable name conflict in
> 2.6.39.

Cool, thx.

g.
