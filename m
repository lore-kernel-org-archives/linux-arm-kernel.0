From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Wed, 10 Jun 2015 21:26:35 +0200
Subject: [PATCH v4] ARM: l2c: add options to overwrite prefetching behavior
In-Reply-To: <20150610172100.230c0e71@free-electrons.com>
References: <1432941541-18588-1-git-send-email-hauke@hauke-m.de>
 <20150610172100.230c0e71@free-electrons.com>
Message-ID: <55788F6B.7060406@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2015 05:21 PM, Thomas Petazzoni wrote:
> Dear Hauke Mehrtens,
> 
> On Sat, 30 May 2015 01:19:01 +0200, Hauke Mehrtens wrote:
>> These options make it possible to overwrites the data and instruction
>> prefetching behavior of the arm pl310 cache controller.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> 
> This patch would be useful to me. I'll test it tomorrow. Did you submit
> it into the Russell patch tracking system, as Russell suggested to do
> in his reply on your v3 ?
> 
> Russell said:
> 
> """
> I don't see anything wrong with it, but as ever, it needs to end up in
> the patch system if it's not going to get buried beneath a huge pile of
> email.
> """
Thanks for asking, I did not know Russell's patch process, but Florian
guided me and now it is submitted, see
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8391/1

Hauke
