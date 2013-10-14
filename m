From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 14 Oct 2013 11:11:29 -0700
Subject: [PATCH stable] ARM: tegra: unify Tegra's Kconfig a bit more
In-Reply-To: <20131010231135.GF4301@kroah.com>
References: <1380917411-25869-1-git-send-email-swarren@wwwdotorg.org>
 <20131005233833.GA18223@kroah.com> <52525247.9060609@nvidia.com>
 <52539F98.2030307@nvidia.com> <20131010231135.GF4301@kroah.com>
Message-ID: <525C33D1.4080509@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On 10/10/2013 04:11 PM, Greg KH wrote:
> On Mon, Oct 07, 2013 at 11:00:56PM -0700, Paul Walmsley wrote:
>
>> Well, here's a public link for it:
>>
>> http://nvt.pwsan.com/pub/linux-stable/testlogs/
>>
>> So far it's seeded with v3.11.[34].  It should update automatically
>> as new releases come out.  So far the tests are quite basic (build +
>> boot to minimal userspace).  Please let Stephen and I know if you
>> have any comments or suggestions.
> That's great to see.  Testing the -rc stable releases would be great, to
> find if I break anything, as I don't have Tegra hardware to test them
> out on.

Could you point out the -rc stable releases that you're referring to?  
Took a look at the linux-stable.git and stable-queue.git trees but was 
unsure what matched that description.

Would this be something like applying the queue-* patches and testing on 
a nightly basis?

- Paul
