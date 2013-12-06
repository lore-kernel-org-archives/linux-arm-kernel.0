From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 06 Dec 2013 13:31:54 -0700
Subject: [PATCH v5 1/3] mfd: tps6586x: add version detection
In-Reply-To: <CAF2Aj3i95j+ZG4gmpSS9Hq6AKXj6w7mB1psYQwT6oas3QfNBrA@mail.gmail.com>
References: <cover.1386333697.git.stefan@agner.ch>	<7812fb79beac0a6a409090f43d129893f9f93b5b.1386333697.git.stefan@agner.ch>	<52A20E09.7090005@wwwdotorg.org>
 <CAF2Aj3i95j+ZG4gmpSS9Hq6AKXj6w7mB1psYQwT6oas3QfNBrA@mail.gmail.com>
Message-ID: <52A2343A.2090008@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/2013 01:24 PM, Lee Jones wrote:
> 
> On 6 Dec 2013 17:49, "Stephen Warren" <swarren@wwwdotorg.org
> <mailto:swarren@wwwdotorg.org>> wrote:
>>
>> On 12/06/2013 05:51 AM, Stefan Agner wrote:
>> > Use the VERSIONCRC to determine the exact device version. According to
>> > the datasheet this register can be used as device identifier. The
>> > identification is needed since some tps6586x regulators use a different
>> > voltage table.
>>
>> FWIW, this version looks good to me now.
> 
> If that's an Ack I can apply it.

Yes, it is. I thought you said you'd already applied it though, so I
didn't write the ack, but if not:

Acked-by: Stephen Warren <swarren@nvidia.com>
