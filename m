From: bp@alien8.de (Borislav Petkov)
Date: Fri, 11 Aug 2017 11:22:25 +0200
Subject: [PATCH v2 2/6] edac: synopsys: Add platform specific structures
 for ddrc controller
In-Reply-To: <9800a639-2e1b-5008-14fc-b2135a27f826@xilinx.com>
References: <91fd6532076e4c905b5a228d852bba4941c54a28.1502091561.git.michal.simek@xilinx.com>
 <6c72eae7c1fbfd2b96d5dc1c7feb251bdbe3e591.1502091561.git.michal.simek@xilinx.com>
 <20170811090926.GC9432@nazgul.tnic>
 <9800a639-2e1b-5008-14fc-b2135a27f826@xilinx.com>
Message-ID: <20170811092225.GE9432@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 11, 2017 at 11:16:15AM +0200, Michal Simek wrote:
> https://lkml.org/lkml/2017/8/7/105
> ACK by Rob yesterday.

Ok, pls bounce it to me as I don't have it.

Also, pls refrain from using lkml.org. Simply do:

http://lkml.kernel.org/r/<Message-ID>

> I am using patman - u-boot tools for sending patch. It read MAINTAINERS
> file and copy right people.
> It has option to explicitly CC people. I need to resend this as v3
> anyway that's why I will add you there.

Yes, if you send cross-maintainer changes, please make sure to CC them on all
patches because otherwise stuff like that happens and people start wondering
where is the rest and so on.

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
