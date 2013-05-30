From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 30 May 2013 16:23:00 +0400
Subject: [PATCH 2/2] ARM: shmobile: r8A7779: fix Ether device name
In-Reply-To: <20130528040043.GL13532@quad.lixom.net>
References: <1369645206-3682-1-git-send-email-horms+renesas@verge.net.au>
 <1369645206-3682-3-git-send-email-horms+renesas@verge.net.au>
 <20130528040043.GL13532@quad.lixom.net>
Message-ID: <51A744A4.5020909@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 28-05-2013 8:00, Olof Johansson wrote:

>> From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> While recasting the commit "ARM: shmobile: R8A7779: add Ether support", I made a
>> typo in the platform device's name: used underscore instead of hyphen.

> Minor nit: if this has been merged, then including the SHA is useful too.

    Yes, it has been merged in 3.10. Simon, can you do this without me 
reposting the patch? The defective commit's SHA1 ID is 
dace48d04dee46a3409d5e13cd98031522e46377.
    Note that there is analogous R8A7778 Ether fix, the SHA1 for its 
defective commit is 524219146a89aee5366326c225ccd71231419d89.

> -Olof

WBR, Sergei
