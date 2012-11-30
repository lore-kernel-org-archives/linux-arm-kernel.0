From: narkewoody@gmail.com (Woody Wu)
Date: Fri, 30 Nov 2012 13:49:36 +0000 (UTC)
Subject: nfs root not responding?
References: <slrnkbgkqq.2kq.narkewoody@zuhnb712.local.com>
 <20121130083252.B4301200171@gemini.denx.de>
Message-ID: <slrnkbhe9o.2ee.narkewoody@zuhnb712.local.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-11-30, Wolfgang Denk <wd@denx.de> wrote:
> Dear Woody Wu,
>
> In message <slrnkbgkqq.2kq.narkewoody@zuhnb712.local.com> you wrote:
>> 
>> I just enabled the network in the kernel and trying to load a rootfs
>> from remote nfs server.  The kernel did the DHCP succeed and got the
>> ip and other network parameters.  But it then keep always complaining
>> that "nfs server not responding" and the login prompt does not show up.
>
> Try adding "proto=tcp" as mount option and test if this changes
> anything.
>

Hi, Wolfgang

Where to specify the option?  Is it something like
nfsroot=....,proto=tcp?  A little confuse to me about mount option and
nfs option.

Thanks.

-- 
woody
I can't go back to yesterday - because I was a different person then.
