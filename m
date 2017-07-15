From: slash.tmp@free.fr (Mason)
Date: Sun, 16 Jul 2017 01:34:53 +0200
Subject: [RFC 1/2] PM / suspend: Add platform_suspend_target_state()
In-Reply-To: <1578637.1XJQpJurXn@aspire.rjw.lan>
References: <20170622085102.mpk7vxodpgxtrlfd@piout.net>
 <20170715164626.GA1373@amd> <1a5ef0ae-16f3-5a61-ae4e-083664cb30c0@gmail.com>
 <1578637.1XJQpJurXn@aspire.rjw.lan>
Message-ID: <53f90d62-111f-57ae-907d-aa347b7033e0@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/07/2017 01:24, Rafael J. Wysocki wrote:

> On Saturday, July 15, 2017 10:20:27 AM Florian Fainelli wrote:
>
>> The enum offers the advantage of centralizing how many different states
>> exist for all the platforms we know about in the kernel, it's easy to
>> define common values for platforms that have the same semantics, just
>> like it's simple to add new values for platform specific details.
> 
> Well, you seem to be liking this, so why don't you just implement it?

At the end of his message, Florian wrote:

> In any case, just agree and I will be happy to follow-up with patches.

Regards.
