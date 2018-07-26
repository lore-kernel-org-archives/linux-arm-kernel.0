From: arun.parameswaran@broadcom.com (Arun Parameswaran)
Date: Thu, 26 Jul 2018 12:00:59 -0700
Subject: [PATCH 0/7] Add clock config and pm support to bcm iProc mdio mux
In-Reply-To: <20180726185246.GE10686@lunn.ch>
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
 <20180726185246.GE10686@lunn.ch>
Message-ID: <c9262069-54ba-6e8b-68f3-0d2b62d1d3ac@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18-07-26 11:52 AM, Andrew Lunn wrote:
> On Thu, Jul 26, 2018 at 11:36:17AM -0700, Arun Parameswaran wrote:
>> Hi,
>> The patchset is based on David Miller's "net" repo.
> 
> Hi Arun
> 
> "net" is intended for bug fixes. This looks like new features, so
> should be against net-next". Please read the netdev FAQ.
> 
>        Andrew
> 
Hi Andrew
The first three patches are 'fixes', and the subsequent patches
(which are new features) depend on the first 3 patches.

Since I had the 'fixes', and the dependency, I used the 'net'
repo.

Please advise if I should still use 'net-next' for all of them.

Thanks
Arun
