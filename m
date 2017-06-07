From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 7 Jun 2017 19:16:52 +0300
Subject: [PATCH v2 0/3] Add R8A7743/SK-RZG1M PFC support
In-Reply-To: <20170424061217.GC14843@verge.net.au>
References: <20170420185132.258111787@cogentembedded.com>
 <20170424061217.GC14843@verge.net.au>
Message-ID: <4937ae78-8800-1a11-547b-2269d063d45a@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2017 09:12 AM, Simon Horman wrote:

>>    Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
>> 'renesas-devel-20170420-v4.11-rc7' tag.  We're adding the R8A7743 PFC node
>> and then describing the pins for SCIF0 and Ether devices declared earlier.
>> These patches depend on the R8A7743 PFC suport in order to work properly.
>
> Thanks. I have marked these as deferred pending acceptance of the PFC
> driver changes. Please repost or otherwise let me know when dependency
> is satisfied.

    FYI, Linus W. has pulled the R8A774x PFC patches for 4.13:

https://www.spinics.net/lists/linux-renesas-soc/msg14824.html

MBR, Sergei
