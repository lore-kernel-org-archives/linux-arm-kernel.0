From: ben@smart-cactus.org (Ben Gamari)
Date: Mon, 07 Dec 2015 22:19:05 +0100
Subject: [PATCH v5 0/12] cpufreq: Add support for Exynos 5800, 5420,
 and 5422
In-Reply-To: <20151203103703.GC2097@ubuntu>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
 <20151203060527.GH4302@ubuntu> <877fkv4ylk.fsf@smart-cactus.org>
 <20151203103703.GC2097@ubuntu>
Message-ID: <87mvtm9cty.fsf@smart-cactus.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 03-12-15, 11:26, Ben Gamari wrote:
>> Sounds reasonable to me. However, I'd just like to reiterate that this
>> line of work can be pursued independently from the upstreaming of this
>> series.
>
> I think this is the right time to upstream the right solution. Just
> try it once, if you face lots of difficulties or issues, then we can
> ofcourse see..
>
It looks like Bartlomiej has picked up this set. Regardless, while
tracking down various devicetree issues I noticed that the cpu-supply
and cpu%d-supply bindings appear to be completely undocumented. It
seem as though this ought to be fixed.

Cheers,

- Ben
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 472 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151207/cc57cb0a/attachment.sig>
