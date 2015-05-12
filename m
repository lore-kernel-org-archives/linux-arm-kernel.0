From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Tue, 12 May 2015 07:03:19 +0200
Subject: [PATCH] ARM: mvebu: add "nor-jedec" flash compatible binding
In-Reply-To: <CACna6rz9cisJt492kPyzX2nbvsSCig-ubhr6eGAxnxHzUNTvag@mail.gmail.com>
References: <1431066023-19479-1-git-send-email-zajec5@gmail.com>
 <5550A92A.2040408@free-electrons.com>
 <CACna6rz9cisJt492kPyzX2nbvsSCig-ubhr6eGAxnxHzUNTvag@mail.gmail.com>
Message-ID: <CACna6rw8nXUO3B+eXZ4dj+Byy9LKCmVMwEqN7OYBjrnqJRXLcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 May 2015 at 07:00, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
> On 11 May 2015 at 15:05, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>> On 08/05/2015 08:20, Rafa? Mi?ecki wrote:
>>> Starting with commits
>>> 8ff16cf ("Documentation: devicetree: m25p80: add "nor-jedec" binding")
>>> 1103b85 ("mtd: m25p80: bind to "nor-jedec" ID, for auto-detection")
>>> we have "nor-jedec" binding indicating support for JEDEC identification.
>>
>> did you actually check that all the NOR flash referenced in the dts supports
>> the JEDEC identification?
>
> Yes, I did, yes, they do.

Oh wait, I just realized I also modified "mr25h256" about which one
I'm not sure. I'll drop this one in the V2 unless I find a proper
documentation meanwhile.

-- 
Rafa?
