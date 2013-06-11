From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 11 Jun 2013 23:49:40 +0400
Subject: [PATCH v2 1/2] ARM: shmobile: r8a7778: fix Ether device name
In-Reply-To: <20130611074850.GE10440@verge.net.au>
References: <201306090123.24709.sergei.shtylyov@cogentembedded.com>
 <20130611074850.GE10440@verge.net.au>
Message-ID: <51B77F54.8030001@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06/11/2013 11:48 AM, Simon Horman wrote:

>> While recasting commit 524219146a89aee5366326c225ccd71231419d89 (ARM: shmobile:
>> R8A7778: add Ether support), I made a typo in the platform device's name: used
>> underscore instead of hyphen.

>> However, there's now patch merged to net-next.git renaming the platform device
>> from "sh-eth" to "r8a777x-ehter", so it makes the most sense to change the name
>> straight to that one.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> ---
>> The patch is atop of the 'renesas-next-20130607' tag of the 'renesas.git' tree
>> and the USB patches I have submitted earlier.

>> Changes in version 2:
>> - changed the platform device's name as in the patch merged to 'net-next.git';
>> - lowercased the SoC name in the subject.

> Thanks, I have queued this up in the soc2 branch.
> My current plan is to let that branch sit in next for a few
> days and then send a pull-request for it to be included in v3.11.

     Could you then merge the BOCK-W Ether support too? The patch 
currently has some offsets applying to 'renesas-next-20130611v2', should 
I respin it?

WBR, Sergei
